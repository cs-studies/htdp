;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-407) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 407.
;; Redesign row-filter using foldr.
;; Once you have done so,
;; you may merge row-project and row-filter into a single function.


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


(define projected-schema
  `(,(make-spec "Name" string?)
    ,(make-spec "Present" boolean?)))

(define projected-content
  `(("Alice" #true)
    ("Bob"   #false)
    ("Carol" #true)
    ("Dave"  #false)))

(define projected-db
  (make-db projected-schema
           projected-content))


;;; Functions

;; DB [List-of Label] -> DB
;; Retains a column from db if its label is in labels.
(check-expect (db-content (project school-db '("Name" "Present"))) projected-content)
(define (project db labels)
  (local ((define schema (db-schema db))
          (define content (db-content db))
          (define schema-labels (map spec-label schema))

          ;; Spec -> Boolean
          (define (keep? s)
            (member? (spec-label s) labels))

          ;; Row -> Row
          (define (row-project row)
            (foldr (lambda (cell label r)
                     (if (member? label labels) (cons cell r) r))
                   '()
                   row
                   schema-labels)))

  (make-db (filter keep? schema)
           (map row-project content))))

