;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-150) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 150.
;; Design the function add-to-pi.
;; Once you have a complete definition, generalize the function to add,
;; which adds a natural number n to some arbitrary number x without using +.


;; An N is one of:
;; – 0
;; – (add1 N)
;; Represents the counting numbers.


;; N -> Number
;; Computes (+ n pi) without using +.
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
(check-within (add-to-pi 0) pi 0.001)
#|
;; Template
(define (add-to-pi n)
  (cond
    [(zero? n) ...]
    [else (... (add-to-pi (sub1 n)) ...)]))
|#
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (add1 (add-to-pi (sub1 n)))]))


;; N Number -> Number
;; Adds a natural number n to arbitrary number x without using +.
(check-within (add 3 pi) (+ 3 pi) 0.001)
(check-within (add 0 pi) pi 0.001)
(check-expect (add 3 2) 5)
(define (add n x)
  (cond
    [(zero? n) x]
    [else (add1 (add (sub1 n) x))]))


;;; Answer
;; check-within is used because pi is an irrational number
;; and arbitrary number x can be an irrational number too.
;; Irrational numbers are not exact numbers,
;; so check-within with its delta parameter comes in handy
;; to test operations on irrational numbers.

