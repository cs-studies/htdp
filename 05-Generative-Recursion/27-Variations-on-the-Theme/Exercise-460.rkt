;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-460) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 460.
;; Develop the algorithm integrate-dc,
;; which integrates a function f between the boundaries a and b
;; using a divide-and-conquer strategy.
;; Use Kepler’s method when the interval is sufficiently small.


(define EPS 0.1)


;; [Number -> Number] Number Number -> Number
;; Computes the area under the graph of f between a and b.
;; Assumes that (< a b) holds.
(check-within (integrate-dc (lambda (x) 20) 12 22) 200 EPS) ; 200
(check-within (integrate-dc (lambda (x) (* 2 x)) 0 10) 100 EPS) ; 100
(check-within (integrate-dc (lambda (x) (* 3 (sqr x))) 0 10) 1000 EPS) ; 1000.007629...
(define (integrate-dc f a b)
  (local ((define mid (/ (+ a b) 2))
          (define delta (- b a)))
    (cond
      [(<= delta EPS) (integrate-kepler f a b)]
      [else (+ (integrate-dc f a mid)
               (integrate-dc f mid b))])))


;; [Number -> Number] Number Number -> Number
;; Computes the area under the graph of f between a and b.
;; Assumes that (< a b) holds.
(check-within (integrate-kepler (lambda (x) 20) 12 22) 200 EPS)
(check-within (integrate-kepler (lambda (x) (* 2 x)) 0 10) 100 EPS)
(define (integrate-kepler f a b)
  (local ((define mid (/ (+ a b) 2))
          (define (trapezoid-area l r)
            (* 0.5 (- r l) (+ (f l) (f r)))))
    (+ (trapezoid-area a mid)
       (trapezoid-area mid b))))

