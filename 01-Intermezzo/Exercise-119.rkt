;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-119) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 119.
;; Explain why the following sentences are syntactically illegal.


(define (f "x") x)
;; - f and x are variables
;; - variable is an expression
;; - "x" is a string value
;; - (define (variable value) expr) is illegal


(define (f x y z) (x))
;; - f, x, y, z are variables
;; - x is an expression
;; - (define (variable variable variable variable) (expr)) is illegal

