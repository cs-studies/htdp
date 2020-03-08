;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-49-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 49.
;; Use the stepper to evaluate the expression for y as 100 and 210.

(define y 100)
;;(define y 210)

(- 200 (cond [(> y 200) 0] [else y]))

