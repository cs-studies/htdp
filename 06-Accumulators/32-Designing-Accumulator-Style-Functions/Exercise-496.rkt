;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-496) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 496.
;; What should the value of a be when n0 is 3 and n is 1?
;; How about when n0 is 10 and n is 8?


;; N is one of:
;; - 0
;; - (add1 N)

;; N -> N
;; Computes factorial of n0.
(check-expect (! 3) 6)
(define (! n0)
  (local (;; N N -> N
          ;; Computes (* n (- n 1) (- n 2) ... 1).
          ;; Accumulator a is the product
          ;; of the natural numbers in the interval [n0,n).
          (define (!/a n a)
            (cond
              [(zero? n) a]
              [else (!/a (sub1 n) (* n a))])))
    (!/a n0 1)))

;;; Answer
;; When n0 is 3 and n is 1,
;; a is the product of numbers in [3,1),
;; which is 3 * 2 = 6.
;;
;; When n0 is 10 and n is 8,
;; a is the product of numbers in [10,8),
;; which is 10 * 9 = 90.

#|
(! 10)
;=
(!/a 10 1)
;=
(!/a 9 (* 10 1))
;=
(!/a 8 (* 9 10 1))
|#

