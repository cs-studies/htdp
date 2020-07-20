;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-40) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 40.
;; Formulate the examples as BSL tests, that is, using the check-expect form.
;; Introduce a mistake. Re-run the tests.

(require 2htdp/universe)

;; Unit tests
(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

;; Definitions
;; WorldState -> WorldState
;; moves the car by 3 pixels for every clock tick
(define (tock ws)
  (+ ws 3))

