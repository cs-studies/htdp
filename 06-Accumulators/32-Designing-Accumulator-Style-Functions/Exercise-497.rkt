;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-497) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 497.
;; Measure how long it takes to evaluate (!.v1 20) 1,000 times.


;; N is one of:
;; - 0
;; - (add1 N)

;; N -> N
;; Computes factorial of n0.
(check-expect (!.v1 3) 6)
(define (!.v1 n)
  (cond
    [(zero? n) 1]
    [else (* n (!.v1 (sub1 n)))]))

;; N -> N
;; Computes factorial of n0.
(check-expect (!.v2 3) 6)
(define (!.v2 n0)
  (local (;; N N -> N
          ;; Computes (* n (- n 1) (- n 2) ... 1).
          ;; Accumulator a is the product
          ;; of the natural numbers in the interval [n0,n).
          (define (!/a n a)
            (cond
              [(zero? n) a]
              [else (!/a (sub1 n) (* n a))])))
    (!/a n0 1)))


;(time (!.v1 1000))
;; n0    1000  2000  4000  10000  20000
;; time     0     0    27    135     48

;(time (!.v2 1000))
;; n0    1000  2000  4000  10000  20000
;; time     0    15    25     11    378


(define (evaluate f n0 times)
  (cond
    [(zero? times) 1]
    [else (+ (f n0) (evaluate f n0 (sub1 times)))]))

;(time (evaluate !.v1 20 1000)) ; 0

;(time (evaluate !.v2 20 1000)) ; 0


;;; See also
;; https://stackoverflow.com/questions/4733456/performance-of-recursion-vs-accumulator-style

