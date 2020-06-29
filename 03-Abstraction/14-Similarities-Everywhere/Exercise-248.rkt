;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-248) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 248.
;; Evaluate with DrRacket's stepper.


;; Number Number -> Boolean
;; Determines whether the area of a square with side x larger than c.
(define (squared>? x c)
  (> (* x x) c))

(squared>? 3 10)

(squared>? 4 10)

