;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-410) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 410.
;; Design the function db-union,
;; which consumes two databases with the exact same schema
;; and produces a new database with this schema
;; and the joint content of both.
;; The function must eliminate rows with the exact same content.


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

(define common-schema
  `(,(make-spec "Name" string?)
    ,(make-spec "Age" integer?)
    ,(make-spec "Present" boolean?)))

(define school1-content
  `(("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))

(define school1-db (make-db common-schema school1-content))


(define school2-content
  `(("Alice" 35 #true)
    ("Amily" 45 #true)
    ("Carol" 30 #true)
    ("Dan"  22 #false)))

(define school2-db (make-db common-schema school2-content))


(define union-content
  `(("Amily" 45 #true)
    ("Dan"  22 #false)
    ("Alice" 35 #true)
    ("Bob"   25 #false)
    ("Carol" 30 #true)
    ("Dave"  32 #false)))

(define union-db (make-db common-schema union-content))


(define ERR-SCHEMA "The exact same schema is required.")


;;; Functions

;; DB DB -> DB
;; Produces a database with the joint content of db1 and db2.
(check-expect (db-content (db-union school1-db school2-db)) union-content)
(check-expect (db-content (db-union
                           (make-db common-schema '(("Bob" 33 #false)))
                           (make-db common-schema '(("Bob" 33 #false)))))
              '(("Bob" 33 #false)))
(check-expect (db-content (db-union
                           (make-db common-schema '(("Bob" 33 #false)))
                           (make-db common-schema
                                    '(("Bob" 33 #false) ("Alice" 22 #true)))))
              '(("Alice" 22 #true) ("Bob" 33 #false)))
(check-error (db-union school1-db
                       (make-db (list (make-spec "Age" integer?))
                                '((22) (23) (24))))
             ERR-SCHEMA)
(define (db-union db1 db2)
  (local ((define schema (db-schema db1))
          (define schema2 (db-schema db2))
          (define content1 (db-content db1))
          (define content2 (db-content db2)))
    (if (not (equal? schema schema2))
        (error ERR-SCHEMA)
        (make-db schema
                 (foldr (lambda (row l) (if (member? row l) l (cons row l)))
                        content1
                        content2)))))

