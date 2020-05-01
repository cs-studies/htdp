;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-120) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 120.
;; Discriminate the legal from the illegal sentences.
;; Explain why the sentences are legal or illegal.
;; Determine whether the legal ones belong to the category expr or def.


(x)
;; - x is a variable
;; - variable is an expression
;; - (expr) is illegal


(+ 1 (not x))
;; - 1 is a value
;; - value is an expression
;; - x is a variable
;; - variable is an expression
;; - not is a primitive
;; - (not x) is a (primitive expr)
;; - (primitive expr) is an expression
;; - (+ 1 (not x) is a (primitive expr expr)
;; - (primitive expr expr) is an expression,
;; though it will not run
;; because + accepts only number arguments
;; but (not x) is always a boolean value


(+ 1 2 3)
;; - 1, 2, 3 are values
;; - values are expressions
;; - + is a primitive
;; - (primitive expr expr expr) is an expression

