;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-243) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 243.
;; Identify the values among the following expressions.


(define (f x) x)

;; a list
(cons f '())
; ==
(list f)

;; a value, because f is a function
(f f)
; ==
f

;; a list
(cons f (cons 10 (cons (f 10) '())))
; ==
(list f 10 10)

