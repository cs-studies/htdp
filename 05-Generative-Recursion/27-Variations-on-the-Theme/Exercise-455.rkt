;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-455) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 455.
;; Translate the mathematical formula for slope into the function slope,
;; which maps function f and a number r1 to the slope of f at r1.


(require 2htdp/image)


(bitmap "./images/xx+x-2.png")

(define f1 (lambda (i) (+ (* i i) i -2)))

(define EPSILON 0.001)


;; [Number -> Number] Number -> Number
;; Produces a slope of f at r1.
(check-expect (slope (lambda (i) i) 0) 1)
(check-expect (slope (lambda (i) i) 10) 1)
(check-expect (slope f1 10) 21)
(check-expect (slope f1 2) 5)
(check-expect (slope f1 -0.5) 0)
(check-expect (slope f1 -2) -3)
(check-expect (slope f1 -2.1) -3.2)
(check-expect (slope f1 -3) -5)
(define (slope f r1)
  (local ((define r0 (- r1 EPSILON))
          (define r2 (+ r1 EPSILON))
          (define f@r0 (f r0))
          (define f@r2 (f r2)))
    (/ (- f@r2 f@r0) (- r2 r0))))
;(/ (- f@r2 f@r0) (* 2 EPSILON))))

