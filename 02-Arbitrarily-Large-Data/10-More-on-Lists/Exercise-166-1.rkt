;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-166-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 166.
;; Part 1.
;; Develop a data representation for paychecks.
;; Then design the function wage*.v3.
;; It consumes a list of work records and computes a list of paychecks from it, one per record.


;;; Data Definitions

(define-struct paycheck [employee amount])
;; A Paycheck is a structure:
;;   (make-paycheck String Number)
;; (make-paycheck n a) combines the name n
;; with the amount a.

;; A List-of-paychecks is one of:
;; - '()
;; - (cons Paycheck List-of-paychecks)

(define-struct work [employee rate hours])
;; A (piece of) Work is a structure:
;;   (make-work String Number Number)
;; (make-work n r h) combines the name n
;; with the pay rate r and the number of hours h.

;; A List-of-works is one of:
;; – '()
;; – (cons Work List-of-works)
;; Represents the hours worked for a number of employees


;;; Functions

;; List-of-works -> List-of-paychecks
;; Produces a list of paychecks.
(check-expect (wage* '()) '())
(check-expect (wage* (cons (make-work "Robby" 11.95 39) '()))
              (cons (make-paycheck "Robby" (* 11.95 39)) '()))
(check-expect (wage* (cons (make-work "Matthew" 12.95 45)
                           (cons (make-work "Robby" 11.95 39) '())))
              (cons (make-paycheck "Matthew" (* 12.95 45))
                    (cons (make-paycheck "Robby" (* 11.95 39)) '())))
(define (wage* l-w)
  (cond
    [(empty? l-w) '()]
    [(cons? l-w) (cons (create-paycheck (first l-w)) (wage* (rest l-w)))]))

;; Work -> Paycheck
;; Constructs the paycheck for the given work record w.
(define (create-paycheck w)
  (make-paycheck (work-employee w) (* (work-rate w) (work-hours w))))


;;; Application

(wage* (cons (make-work "Matthew" 12.95 45) (cons (make-work "Robby" 11.95 39) '())))

