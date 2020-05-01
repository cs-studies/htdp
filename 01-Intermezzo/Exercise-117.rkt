;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-117) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 117.
;; Explain why the following sentences are syntactically illegal.


(3 + 4)
;; - 3 and 4 are values
;; - values are expressions
;; - + is a privitive
;; - (expr primitive expr) is illegal


number?
;; - number? is primitive
;; - primitive is illegal


(x)
;; - x is a variable
;; - (variable) is illegal

