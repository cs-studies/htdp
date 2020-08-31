;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-414) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 414.
;; Design add, a function that adds up n copies of #i1/185.
;; For your examples, use 0 and 1; for the latter, use a tolerance of 0.0001.
;;
;; Design sub.
;; The function counts how often 1/185 can be subtracted
;; from the argument until it is 0.
;; Use 0 and 1/185 for your examples.


(define i #i1/185)

;; Number -> Number
;; Adds up n copies of #i1/185.
(check-within (add 0) i 0.0001)
(check-within (add 1) (+ i i) 0.0001)
(check-within (add 185) 1 0.01)
(check-within (add 1000) 5.4 0.1)
(define (add n)
  (cond
    [(= n 0) i]
    [else (+ i (add (sub1 n)))]))

;; Number -> Number
;; Counts how often #i1/185
;; can be subtracted from arg until it is 0.
(check-expect (sub 0) 0)
(check-expect (sub 1/185) 0)
(check-expect (sub i) 1)
(check-expect (sub 2/185) 2)
(check-expect (sub 60/185) 60)
(check-expect (sub 96/185) 96)
(check-expect (sub 99/185) 99)
(check-expect (sub 1) 185)
(check-expect (sub #i1.0) 185)
(define (sub arg)
  (cond
    [(< arg i) 0] ; cannot subtract i anymore.
    [else (add1 (sub (- arg i)))]))

