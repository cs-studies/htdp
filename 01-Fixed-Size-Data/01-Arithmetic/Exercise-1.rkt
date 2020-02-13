;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; Definitions
(define x 3)
(define y 4)

; Functions
(define (calculate-distance x y) (sqrt (+ (* x x) (* y y))))

; Application
(calculate-distance x y)

(calculate-distance 12 5)
