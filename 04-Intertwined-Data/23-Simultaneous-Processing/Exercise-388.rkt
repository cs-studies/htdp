;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-388) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 388.
;; Modify wages* so that it works on the more realistic versions of data.


;;; Data Definitions

(define-struct employee [name ssn rate])
;; An Employee is a structure:
;;    (make-employee String Number Number)
;; (make-employee n ssn r) represents an employee
;; with the name n, social security number ssn,
;; and the pay rate r.

(define-struct wr [employee hours])
;; A WR (short for Work Record) is a structure:
;;     (make-wr String Number)
;; (make-wr n h) represents a work record
;; of an employee with the name n,
;; with the number of worked hours h.

(define-struct wage [employee amount])
;; A Wage is a structure:
;;    (make-wage String Number)
;; (make-wage n a) represents a weekly wage amount a
;; of an employee with the name n.


;;; Tests Constants

(define e-1 (make-employee "Dan" 22222 25))
(define e-2 (make-employee "Emily" 33333 35))
(define e-3 (make-employee "Maxine" 44444 45))

(define wr-11 (make-wr "Dan" 2))
(define wr-12 (make-wr "Dan" 4))
(define wr-13 (make-wr "Dan" 8))
(define wr-21 (make-wr "Emily" 4))
(define wr-22 (make-wr "Emily" 3))
(define wr-31 (make-wr "Maxine" 1))


;;; Functions

;; [List-of Employee] [List-of WR] -> [List-of Wage]
;; Produces a list of weekly wages grouped by employees.
(check-expect (wages* '() '()) '())
(check-expect (wages* `(,e-1) `(,wr-11)) (list (make-wage "Dan" 50)))
(check-expect (wages* `(,e-1) `(,wr-11 ,wr-12)) (list (make-wage "Dan" 150)))
(check-expect (wages* `(,e-1 ,e-2) `(,wr-11 ,wr-21))
              (list (make-wage "Dan" 50)
                    (make-wage "Emily" 140)))
(check-expect (wages* `(,e-1 ,e-2 ,e-3) `(,wr-11 ,wr-12 ,wr-13 ,wr-21 ,wr-22 ,wr-31))
              (list (make-wage "Dan" 350)
                    (make-wage "Emily" 245)
                    (make-wage "Maxine" 45)))
(define (wages* loe lowr)
  (cond
    [(empty? loe) '()]
    [else (cons (weekly-wage (first loe) lowr)
                (wages* (rest loe) lowr))]))

;; Employee [List-of WR] -> Wage
;; Calculates an employee's weekly wage.
(check-expect (weekly-wage e-1 '()) (make-wage "Dan" 0))
(check-expect (weekly-wage e-1 `(,wr-21)) (make-wage "Dan" 0))
(check-expect (weekly-wage e-1 `(,wr-11)) (make-wage "Dan" 50))
(check-expect (weekly-wage e-1 `(,wr-11 ,wr-12)) (make-wage "Dan" 150))
(define (weekly-wage e lowr)
  (local ((define name (employee-name e))
          (define rate (employee-rate e)))
    (make-wage
     name
     (foldr (lambda (wr wage)
              (+ wage
                 (if (string=? name (wr-employee wr))
                     (* rate (wr-hours wr))
                     0)))
            0 lowr))))

