;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-408) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 408.
;; Design the function select.
;; It consumes a database, a list of labels, and a predicate on rows.
;; The result is a list of rows that satisfy the given predicate,
;; projected down to the given set of labels.


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


;;; Functions

;; DB [List-of Label] Predicate -> Content
;; Produces a list of rows that:
;; - satisfy the given predicate
;; - projected down to the given set of labels.
(check-expect (select1 school-db '("Name" "Present") (lambda (r)(false? (third r))))
              `(("Bob" #false)
                ("Dave" #false)))
(check-expect (select1 school-db '("Name" "Present") (lambda (r)(<= (second r) 30)))
              `(("Bob" #false)
                ("Carol" #true)))
(check-expect (select1 school-db '("Age") (lambda (r) (false? #false)))
              `((35) (25) (30) (32)))
(define (select1 db labels p)
  (local ((define schema (db-schema db))
          (define content (db-content db))

          ;; Spec -> Boolean
          (define (keep? s)
            (member? (spec-label s) labels))

          (define mask (map keep? schema))

          ;; Row -> Row
          (define (row-project row)
            (foldr (lambda (cell m r)
                     (if m (cons cell r) r))
                   '()
                   row
                   mask)))

    (map row-project (filter p (db-content db)))))


;; DB [List-of Label] Predicate -> Content
;; Uses alternate approach that
;; processes filtering and projection in parallel.
(check-expect (select2 school-db '("Name" "Present") (lambda (r)(false? (third r))))
              `(("Bob" #false)
                ("Dave" #false)))
(check-expect (select2 school-db '("Name" "Present") (lambda (r)(<= (second r) 30)))
              `(("Bob" #false)
                ("Carol" #true)))
(check-expect (select2 school-db '("Age") (lambda (r) (false? #false)))
              `((35) (25) (30) (32)))
(define (select2 db labels p)
  (local (;; Content -> Content
          (define (select-filtered content)
            (cond
              [(empty? content) '()]
              [else
               (local ((define filtered (select-filtered (rest content))))
                 (if (p (first content))
                     (cons (row-project (first content)) filtered)
                     filtered))]))

          (define mask
            (map (lambda (s) (member? (spec-label s) labels))
                 (db-schema db)))

          ;; Row -> Row
          (define (row-project row)
            (foldr (lambda (cell m r)
                     (if m (cons cell r) r))
                   '()
                   row
                   mask)))

    (select-filtered (db-content db))))

