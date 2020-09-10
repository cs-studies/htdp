;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-458) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 458.
;; Design the function integrate-kepler.


(define EPS 0.1)


;; [Number -> Number] Number Number -> Number
;; Computes the area under the graph of f between a and b.
;; Assumes that (< a b) holds.
(check-within (integrate-kepler (lambda (x) 20) 12 22) 200 EPS) ; 200
(check-within (integrate-kepler (lambda (x) (* 2 x)) 0 10) 100 EPS) ; 100
;(check-within (integrate-kepler (lambda (x) (* 3 (sqr x))) 0 10) 1000 EPS) ; 1125
(define (integrate-kepler f a b)
  (local ((define mid (/ (+ a b) 2))
          (define (trapezoid-area l r)
            (* 0.5 (- r l) (+ (f l) (f r)))))
    (+ (trapezoid-area a mid)
       (trapezoid-area mid b))))


; (R - L) * R' + 1/2 * (R - L) * (L' - R')
; =
; R * R' - L * R' + 1/2 * (R * L' - R * R' - L * L' + L * R')
; =
; R * R' - L * R' + 1/2 * R * L' - 1/2 * R * R' - 1/2 * L * L' + 1/2 * L * R'
; =
; (R * R' - 1/2 * R * R') - (L * R' - 1/2 * L * R') + 1/2 * R * L' - 1/2 * L * L'
; =
; 1/2 * R * R' - 1/2 * L * R' + 1/2 * R * L' - 1/2 * L * L'
; =
; 1/2 * R' * (R - L) + 1/2 * L' * (R - L)
; =
; 1/2 * (R - L) * (R' + L')


;;; Which of the three tests fails and by how much?
;; The third test fails by 12.5%.


;;; Note
;; Betterexplained on integrals:
;; https://betterexplained.com/articles/a-calculus-analogy-integrals-as-multiplication/

