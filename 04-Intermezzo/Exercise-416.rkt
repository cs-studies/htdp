;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-416) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 416.
;; ISL+ uses #i0.0 to approximate underflow.
;; Determine the smallest integer n such that
;; (expt #i10.0 n) is still an inexact ISL+ number
;; and (expt #i10. (- n 1)) is approximated with 0.


;; N is one of:
;; - 0
;; - (add1 N)


;; N -> N
;; Determines the integer n such that:
;; - (expt #i10.0 n) is an inexact number
;; - (expt #i10.0 (- n 1)) is approximated with #i0.0.
(define (compute n)
  (cond
    [(equal? #i0.0 (expt #i10.0 n)) (+ n 1)]
    [else (compute (sub1 n))]))


;;; Application

(compute 0) ; -323

(expt #i10. -323)
;; #i9.8813129168249e-324

(expt #i10. -324)
;; #i0.0

