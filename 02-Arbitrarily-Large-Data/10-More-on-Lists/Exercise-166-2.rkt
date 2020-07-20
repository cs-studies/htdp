;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-166-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 166.
;; Part 2.
;; Develop a data representation for employee information
;; and change the data definition for work records
;; so that it uses employee information
;; and not just a string for the employee’s name.
;; Also change your data representation of paychecks
;; so that it contains an employee’s name and number, too.
;; Finally, design wage*.v4,
;; a function that maps lists of revised work records to lists of revised paychecks.


;;; Data Definitions

(define-struct employee [id name])
;; An Employee is a structure:
;;   (make-employee Number String)
;; (make-employee id n) represents an employee
;; with the number id and the name n.

(define-struct paycheck [employee amount])
;; A Paycheck is a structure:
;;   (make-paycheck Employee Number)
;; (make-paycheck e a) combines the employee e
;; with the amount a.

;; A List-of-paychecks is one of:
;; - '()
;; - (cons Paycheck List-of-paychecks)

(define-struct work [employee rate hours])
;; A (piece of) Work is a structure:
;;   (make-work Employee Number Number)
;; (make-work e r h) combines the employee e
;; with the pay rate r and the number of hours h.

;; A List-of-works is one of:
;; – '()
;; – (cons Work List-of-works)
;; Represents the hours worked for a number of employees.


;;; Constants

(define ROBBY (make-employee 33333 "Robby"))
(define MATTHEW (make-employee 99999 "Matthew"))


;;; Functions

;; List-of-works -> List-of-paychecks
;; Produces a list of paychecks.
(check-expect (wage* '()) '())
(check-expect (wage* (cons (make-work ROBBY 11.95 39) '()))
              (cons (make-paycheck ROBBY (* 11.95 39)) '()))
(check-expect (wage* (cons (make-work MATTHEW 12.95 45)
                           (cons (make-work ROBBY 11.95 39) '())))
              (cons (make-paycheck MATTHEW (* 12.95 45))
                    (cons (make-paycheck ROBBY (* 11.95 39)) '())))
(define (wage* l-w)
  (cond
    [(empty? l-w) '()]
    [(cons? l-w) (cons (create-paycheck (first l-w)) (wage* (rest l-w)))]))

;; Work -> Paycheck
;; Constructs the paycheck for the given work record w.
(define (create-paycheck w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))


;;; Application

;(wage* (cons (make-work MATTHEW 12.95 45) (cons (make-work ROBBY 11.95 39) '())))

