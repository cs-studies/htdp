;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-118) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 118.
;; Explain why the following sentences are syntactically legal definitions.


(define (f x) x)
;; - f and x are variables
;; - variable is an expression
;; - (define (variable variable) expr) is a definition


(define (f x) y)
;; - f, x, y are variables
;; - y is an expression
;; - (define (variable variable) expr) is a definition


(define (f x y) 3)
;; - f, x, y are variables
;; - 3 is a value
;; - value is an expression
;; - (define (variable variable variable) expr) is a definition

