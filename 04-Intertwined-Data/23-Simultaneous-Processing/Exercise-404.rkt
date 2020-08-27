;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-404) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 404.
;; Design the function andmap2.
;; It consumes a function f from two values to Boolean and two equally long lists.
;; Its result is also a Boolean.
;; Specifically, it applies f to pairs of corresponding values from the two lists,
;; and if f always produces #true, andmap2 produces #true, too.
;; Otherwise, andmap2 produces #false.


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


(define presence-schema
  `(,(make-spec "Present" boolean?)
    ,(make-spec "Description" string?)))

(define presence-content
  `((#true  "presence")
    (#false "absence")))

(define presence-db
  (make-db presence-schema
           presence-content))


;;; Functions

;; DB -> Boolean
;; Determines whether all rows in db
;; satisfy integrity constraint (I1) and (I2).
(check-expect (integrity-check school-db) #true)
(check-expect (integrity-check presence-db) #true)
(check-expect (integrity-check (make-db presence-schema school-content)) #false)
(check-expect (integrity-check (make-db school-schema presence-content)) #false)
(define (integrity-check db)
  (local ((define schema (db-schema db))
          (define schema-length (length schema))
          ;; Schema -> [List-of Predicate]
          (define (predicates sch)
            (map (lambda (s) (spec-predicate s)) sch))
          ;; Row -> Boolean
          (define (row-integrity-check row)
            (local (;; Row -> Boolean
                    (define (check-row-length row)
                      (= (length row) schema-length))
                    ;; Row -> Boolean
                    (define (check-every-cell row)
                      (andmap2 (lambda (p v) (p v))
                               (predicates schema)
                               row)))
              (and (check-row-length row)
                   (check-every-cell row)))))
    (andmap row-integrity-check (db-content db))))


;; [X Y] [X Y -> Boolean] [List-of X] [List-of Y] -> Boolean
;; Determines whether f holds for every item on lx and ly.
(check-error (andmap2 = '() '(1)) "lx and ly must equally long.")
(check-expect (andmap2 = '() '()) #true)
(check-expect (andmap2 = '(2 3) '(2 3)) #true)
(check-expect (andmap2 = '(1 2) '(2 3)) #false)
(check-expect (andmap2 (lambda (x y) (x y)) `(,string?) '(1)) #false)
(check-expect (andmap2 (lambda (x y) (x y)) `(,string?) '(a)) #false)
(check-expect (andmap2 (lambda (x y) (x y)) `(,string?) '("a")) #true)
(check-expect (andmap2 (lambda (x y) (x y)) `(,string? ,boolean?) '(1 #true)) #false)
(check-expect (andmap2 (lambda (x y) (x y)) `(,string? ,boolean?) '("a" 10)) #false)
(check-expect (andmap2 (lambda (x y) (x y)) `(,string? ,boolean?) '("b" #true)) #true)
(check-expect (andmap2 (lambda (x y) (x y)) `(,string? ,boolean?) '("a" #false)) #true)
(define (andmap2 f lx ly)
  (if (not (= (length lx) (length ly)))
      (error "lx and ly must equally long.")
      (cond
        [(empty? lx) #true]
        [else (and (f (first lx) (first ly))
                   (andmap2 f (rest lx) (rest ly)))])))

