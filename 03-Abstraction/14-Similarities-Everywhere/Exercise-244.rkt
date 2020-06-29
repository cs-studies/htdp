;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-244) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 244.
;; Argue why the following sentences are now legal.


(define (f x) (x 10))

(define (f1 x1) (x1 f1))

(define (f2 x y) (x 'a y 'b))


;;; Answer.
;; Function arguments can be functions themselves.


;;; Application

;(f add1)

