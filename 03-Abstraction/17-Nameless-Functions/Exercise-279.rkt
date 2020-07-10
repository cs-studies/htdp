;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-279) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 279.
;; Decide which of the following phrases are legal lambda expressions.


;(lambda (x y) (x y y))
;; Invalid.
;; (x y y) is not a valid expression (see Intermezzo 1).
;; Using a primitive would make (+ x y y)
;; a valid expression and fix lambda expression.


;(lambda () 10)
;; Invalid.
;; The keyword lambda must be followed
;; by a sequence of variables.


;(lambda (x) x)
;; Valid.
;; The expression consists of the keyword lambda,
;; a variable enclosed in a pair of parentheses,
;; followed by a valid expression (variable in this case).


;(lambda (x y) x)
;; Valid.
;; Consists of keyword, variables, and a valid expression.


;(lambda x 10)
;; Invalid.
;; A variable must be enclosed in a pair of parentheses.

