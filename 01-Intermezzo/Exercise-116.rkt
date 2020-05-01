;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-116) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 116.
;; Explain why the following sentences are syntactically legal expressions.


x
;; - x is a variable
;; - any variable is a valid expression


(= y z)
;; - y and z are variables
;; - variables are expressions
;; - = is a primitive
;; - (= y z) is a (primitive expr expr)
;; - (primitive expr expr) is an expression


(= (= y z) 0)
;; - (= y z) is an expression, as shown in the previous example
;; - 0 is a value
;; - value is an expression
;; - = is a primitive
;; - (primitive expr expr) is an expression

