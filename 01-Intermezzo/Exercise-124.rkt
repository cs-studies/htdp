;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-124) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 124.
;; Evaluate the following program, step-by-step:

(define PRICE 5)
(define SALES-TAX (* 0.08 PRICE))
(define TOTAL (+ PRICE SALES-TAX))
#|
;; ==
(define PRICE 5)
(define SALES-TAX (* 2/25 PRICE))
;; ==
(define PRICE 5)
(define SALES-TAX (* 2/25 5))
;; ==
(define PRICE 5)
(define SALES-TAX 2/5)
;; ==
(define PRICE 5)
(define SALES-TAX 2/5)
(define TOTAL (+ PRICE SALES-TAX))
;; ==
(define PRICE 5)
(define SALES-TAX 2/5)
(define TOTAL (+ 5 SALES-TAX))
;; ==
(define PRICE 5)
(define SALES-TAX 2/5)
(define TOTAL (+ 5 2/5))
;; ==
(define PRICE 5)
(define SALES-TAX 0.4)
(define TOTAL 27/5)
|#


;;; Question 1
;; Does the evaluation of the following program signal an error?
#|
(define COLD-F 32)
(define COLD-C (fahrenheit->celsius COLD-F))
(define (fahrenheit->celsius f)
 (* 5/9 (- f 32)))
|#
;;; Answer 1
;; Yes: fahrenheit->celsius is used here before its definition


;;; Question 2
;; How about the next one?
(define LEFT -100)
(define RIGHT 100)
(define (f x) (+ (* 5 (expt x 2)) 10))
(define f@LEFT (f LEFT))
(define f@RIGHT (f RIGHT))

;;; Answer 2
;; No error.

