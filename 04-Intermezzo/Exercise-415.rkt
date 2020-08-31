;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-415) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 415.
;; ISL+ uses +inf.0 to deal with overflow.
;; Determine the integer n such that (expt #i10.0 n)
;; is an inexact number while (expt #i10. (+ n 1)) is approximated with +inf.0.
;; Hint Design a function to compute n.


;; N is one of:
;; - 0
;; - (add1 N)


;; N -> N
;; Determines the integer n such that:
;; - (expt #i10.0 n) is an inexact number
;; - (expt #i10.0 (+ n 1)) is approximated with +inf.0.
(define (compute n)
  (cond
    [(not (integer? (expt #i10.0 n))) (- n 1)]
    [else (compute (add1 n))]))


;;; Application

(compute 0) ; 308

(expt #i10. 308)
;; #i1e+308

(expt #i10. 309)
;; #i+inf.0

