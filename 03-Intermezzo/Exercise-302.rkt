;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-302) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 302.


;; error: x is used here before its definition
;(define x (cons 1 x))

;; The right-hand side variable must be defined
;; before its usage in a constant definition,
;; so the constant definition could be evaluated immediately.

;; Keep (cons 1 x) evaluation and avoid error.
(define x (lambda (x) (cons 1 x)))

;; Usage
(x '(2 3)) ; outputs '(1 2 3)

