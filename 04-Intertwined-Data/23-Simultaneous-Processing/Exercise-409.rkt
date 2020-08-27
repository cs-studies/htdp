;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-409) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 409.
;; Design reorder.
;; The function consumes a database db and list lol of Labels.
;; It produces a database like db but with its columns reordered according to lol.


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
  (make-db school-schema
           school-content))

(define reordered-schema
  `(,(make-spec "Age" integer?)
    ,(make-spec "Present" boolean?)
    ,(make-spec "Name" string?)))

(define reordered-content
  `((35 #true "Alice")
    (25 #false "Bob")
    (30 #true "Carol")
    (32 #false "Dave")))

(define reordered-db
  (make-db reordered-schema
           reordered-content))


(define ERR-LENGTH "Labels quantity mismatch.")
(define ERR-NOT-FOUND "Label not found.")


;;; Functions

;; DB [List-of Label] -> DB
;; Produces a database like db
;; but with columns reordered according to lol.
(check-expect (db-content (reorder school-db '("Age" "Present" "Name")))
              reordered-content)
(check-error (reorder school-db '("Age" "Name")) ERR-LENGTH)
(check-error (reorder school-db '("Age" "Wrong")) ERR-NOT-FOUND)
(define (reorder db lol)
  (local ((define schema (db-schema db))
          (define content (db-content db))

          (define indexes
            (local ((define (get-index schema label)
                      (cond
                        [(empty? schema) (error ERR-NOT-FOUND)]
                        [else (if (string=? (spec-label (first schema)) label)
                                  0
                                  (add1 (get-index (rest schema) label)))])))
              (map (lambda (label) (get-index schema label)) lol)))

          ;; Row -> Row
          (define (reorder-row r)
            (map (lambda (i) (list-ref r i)) indexes)))

    (if (not (= (length schema) (length lol)))
        (error ERR-LENGTH)
        (make-db (map (lambda (i) (list-ref schema i)) indexes)
                 (map reorder-row content)))))


;;; FIRST DRAFT with higher verbosity

;; DB [List-of Label] -> DB
;; Produces a database like db
;; but with columns reordered according to lol.
(check-expect (db-content (reorder2 school-db '("Age" "Present" "Name")))
              reordered-content)
(check-error (reorder2 school-db '("Age" "Name")) ERR-LENGTH)
(check-error (reorder2 school-db '("Age" "Wrong")) ERR-NOT-FOUND)
(define (reorder2 db lol)
  (local ((define schema (db-schema db))
          (define content (db-content db))
          (define indexes (get-indexes schema lol))

          (define (reorder-row r)
            (reorder-row* r indexes)))

    (if (= (length schema) (length lol))
        (make-db (reorder-schema schema indexes)
                 (map reorder-row content))
        (error ERR-LENGTH))))

;; Schema [List-of Label] -> [List-of Number]
;; Produces a list of schema's indexes
;; ordered accordingly to the list of labels.
(check-expect (get-indexes '() '()) '())
(check-expect (get-indexes school-schema '("Age" "Present" "Name")) '(1 2 0))
(check-expect (get-indexes school-schema '("Name" "Age" "Present")) '(0 1 2))
(define (get-indexes schema lol)
  (cond
    [(empty? lol) '()]
    [else (cons (get-index schema (first lol))
                (get-indexes schema (rest lol)))]))

;; Schema Label -> Number
;; Produces index of a spec in schema found by a label.
(check-error (get-index '() "Age") ERR-NOT-FOUND)
(check-error (get-index `(,(make-spec "Name" string?)) "Age") ERR-NOT-FOUND)
(check-expect (get-index `(,(make-spec "Name" string?)) "Name") 0)
(check-expect (get-index school-schema "Age") 1)
(check-expect (get-index school-schema "Present") 2)
(define (get-index s label)
  (cond
    [(empty? s) (error ERR-NOT-FOUND)]
    [else (if (string=? (spec-label (first s)) label)
              0
              (add1 (get-index (rest s) label)))]))

;; Schema [List-of Number] -> Schema
;; Produces a schema like s
;; but with columns reordered according to the giver order.
(check-expect (reorder-schema '() '()) '())
(check-expect (reorder-schema school-schema '(0 1 2)) school-schema)
(check-expect (map (lambda (s) (spec-label s))
                   (reorder-schema school-schema '(1 2 0)))
              '("Age" "Present" "Name"))
(define (reorder-schema s indexes)
  (cond
    [(empty? indexes) '()]
    [else (cons (list-ref s (first indexes))
                (reorder-schema s (rest indexes)))]))

;; Row [List-of Number] -> Row
;; Produces a row like r
;; but with cells ordered according to the given order.
(check-expect (reorder-row* '() '()) '())
(check-expect (reorder-row* '("Alice" 35 #true) '(0 1 2)) '("Alice" 35 #true))
(check-expect (reorder-row* '("Alice" 35 #true) '(2 0 1)) '(#true "Alice" 35))
(define (reorder-row* r indexes)
  (cond
    [(empty? indexes) '()]
    [else (cons (list-ref r (first indexes))
                (reorder-row* r (rest indexes)))]))

