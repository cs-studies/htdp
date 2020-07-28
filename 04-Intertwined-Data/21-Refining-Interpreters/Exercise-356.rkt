;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-356) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 356.
;; Extend the data representation of Interpreting Variables
;; to include the application of a programmer-defined function.
;; Represent the following expressions.


(define-struct add [left right])

(define-struct mul [left right])

(define-struct fun [name arg])

;; A BSL-fun-expr is one of:
;; – Number
;; – Symbol
;; – (make-add BSL-fun-expr BSL-fun-expr)
;; – (make-mul BSL-fun-expr BSL-fun-expr)
;; - (make-fun Symbol BSL-fun-expr)


;(k (+ 1 1))
; ==
(make-fun 'k (make-add 1 1))

;(* 5 (k (+ 1 1)))
; ==
(make-mul 5 (make-fun 'k (make-add 1 1)))

;(* (i 5) (k (+ 1 1)))
; ==
(make-mul (make-fun 'i 5) (make-fun 'k (make-add 1 1)))

