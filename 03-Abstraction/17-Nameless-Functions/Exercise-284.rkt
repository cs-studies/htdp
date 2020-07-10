;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-284) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 284.
;; Step through the evaluation of these expressions.


((lambda (x) x) (lambda (x) x))
; ==
;(lambda (x) x)


((lambda (x) (x x)) (lambda (x) x))
; ==
;((lambda (x) x) (lambda (x) x))
; ==
;(lambda (x) x)


;; Be ready to hit STOP.
;((lambda (x) (x x)) (lambda (x) (x x)))

