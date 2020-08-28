;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-411) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 411.
;; Design join,
;; a function that consumes two databases: db-1 and db-2.
;; The schema of db-2 starts with the exact same Spec
;; that the schema of db-1 ends in.
;; The function creates a database from db-1
;; by replacing the last cell in each row
;; with the translation of the cell in db-2.


;;; Data Definitions

;; A Label is a String.

;; A Predicate is a [Any -> Boolean].

(define-struct spec [label predicate])
;; A Spec is a structure: (make-spec Label Predicate).

;; A Schema is a [List-of Spec].


;; A Cell is Any.
;; Constraint: cells do not contain functions.

;; A Row is a [List-of Cell].

;; A (piece of) Content is a [List-of Row].


(define-struct db [schema content])
;; A DB is a structure: (make-db Schema Content).
;; Integrity constraint:
;; for every row in content
;; - its length is the same as schema's (I1)
;; - its i-th Cell satisfies the i-th Predicate in schema (I2).


;;; Constants

(define school-schema
  `(,(make-spec "Name" string?)
    ,(make-spec "Age" integer?)
    ,(make-spec "Present" boolean?)))

(define school-content
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))

(define school-db
  (make-db school-schema school-content))


(define presence-schema
  `(,(make-spec "Present" boolean?)
    ,(make-spec "Description" string?)))

(define presence-content
  `((#true  "presence")
    (#false "absence")))

(define presence-db
  (make-db presence-schema presence-content))


(define j-schema
  `(,(make-spec "Name" string?)
    ,(make-spec "Age" integer?)
    ,(make-spec "Description" string?)))

(define j-content
  `(("Alice" 35 "presence")
    ("Bob"   25 "absence")
    ("Carol" 30 "presence")
    ("Dave"  32 "absence")))

(define j-db
  (make-db j-schema presence-content))


(define multi-content
  `((#true  "presence")
    (#true  "here")
    (#false "absence")
    (#false "there")))

(define multi-db
  (make-db presence-schema multi-content))


(define j-multi-content
  `(("Alice" 35 "presence")
    ("Alice" 35 "here")
    ("Bob"   25 "absence")
    ("Bob"   25 "there")
    ("Carol" 30 "presence")
    ("Carol" 30 "here")
    ("Dave"  32 "absence")
    ("Dave"  32 "there")))

(define j-multi-db
  (make-db j-schema j-multi-content))


;;; Functions

;; DB DB -> DB
;; Produces a database from db1
;; by replacing the last cell in each row
;; with the translation of the cell in db2.
(check-expect (db-content (join school-db presence-db)) j-content)
(define (join db1 db2)
  (local ((define schema1 (db-schema db1))
          (define schema2 (db-schema db2))
          (define content1 (db-content db1))
          (define content2 (db-content db2))
          (define join-content
            (local ((define (translate cell)
                      (second (assoc cell content2)))
                    (define (traverse row)
                      (cond
                        [(empty? row) '()]
                        [else (cons
                               (if (empty? (rest row))
                                   (translate (first row))
                                   (first row))
                               (traverse (rest row)))])))
              (map traverse content1))))
    (make-db (join-schema schema1 schema2) join-content)))

;; Schema Schema -> Schema
;; Produces a schema like s1
;; but with the last cell replaced
;; by the second cell of s2.
(define (join-schema s1 s2)
  (cond
    [(empty? s1) '()]
    [else (cons (if (empty? (rest s1))
                    (second s2)
                    (first s1))
                (join-schema (rest s1) s2))]))


;; DB DB -> DB
;; Produces a database from db1
;; by creating rows (with translated last cell)
;; for each translation in db2.
(check-expect (db-content (join-multi school-db multi-db)) j-multi-content)
(define (join-multi db1 db2)
  (local ((define schema1 (db-schema db1))
          (define schema2 (db-schema db2))
          (define content1 (db-content db1))
          (define content2 (db-content db2))
          (define last-index (- (length schema1) 1))

          ;;; Example
          ;; content1: '(("Alice" 33 #true) ("Bob" 35 #false) ("Am" 44 #false))
          ;; content2: '((#true "p") (#true "h") (#false "a") (#false "t")))
          ;; translations: '(("p" "h") ("a" "t") ("a" "t"))
          (define translations
            (map (lambda (row1)
                   (foldr (lambda (row2 l)
                            (if (eq? (list-ref row1 last-index) (first row2))
                                (cons (second row2) l)
                                l))
                          '()
                          content2))
                 content1)))
    (make-db (join-schema schema1 schema2)
             (join-content content1 translations))))


;; Content [List-of [List-of X]] -> Content
;; Produces rows like in content
;; but with translated last cell,
;; creating a row per each translation.
(check-expect (join-content '() '()) '())
(check-expect (join-content '(("Alice" 35 #true)) '(("presence" "here")))
              '(("Alice" 35 "presence") ("Alice" 35 "here")))
(check-expect (join-content '(("Alice" 35 #true)
                              ("Bob" 22 #false)
                              ("Dan" 50 #true))
                            '(("presence" "here")
                              ("absence" "there")
                              ("presence" "here")))
              '(("Alice" 35 "presence")
                ("Alice" 35 "here")
                ("Bob" 22 "absence")
                ("Bob" 22 "there")
                ("Dan" 50 "presence")
                ("Dan" 50 "here")))
(define (join-content content translations)
  (local ((define (translate row t)
            (cond
              [(empty? row) '()]
              [else (cons (if (empty? (rest row))
                              t
                              (first row))
                          (translate (rest row) t))])))
    (foldr (lambda (row trs l)
             (append
              (map (lambda (t) (translate row t)) trs)
              l))
           '()
           content
           translations)))

