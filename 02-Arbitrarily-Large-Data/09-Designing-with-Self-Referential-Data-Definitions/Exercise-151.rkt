;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-151) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 151.
;; Design the function multiply.
;; How does multiply relate to what you know from grade school?

;; An N is one of:
;; – 0
;; – (add1 N)
;; Represents the counting numbers.


;; N Number -> Number
(check-expect (multiply 2 3) 6)
(check-expect (multiply 1 3) 3)
(check-expect (multiply 0 3) 0)
(check-expect (multiply 0 pi) 0)
(check-within (multiply 3 pi) (* 3 pi) 0.001)
#|
;; Template
(define (multiply n x)
  (cond
    [(zero? n) ...]
    [else (... (multiply (sub1 n) x) ...)]))
|#
(define (multiply n x)
  (cond
    [(zero? n) 0]
    [else (+ x (multiply (sub1 n) x))]))


;;; Answer
;; The flow of this function exhibits what multiplication is basically:
;; summing up some value with itself n times.

