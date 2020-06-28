;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-237) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 237.
;; Evaluate (squared>? 3 10) and (squared>? 4 10) in DrRacket.
;; How about (squared>? 5 10)?


;; Number Number -> Boolean
;; Determines whether the area of a square with side x larger than c.
(define (squared>? x c)
  (> (* x x) c))


(squared>? 4 10)

(squared>? 5 10)

(squared>? 6 10)

