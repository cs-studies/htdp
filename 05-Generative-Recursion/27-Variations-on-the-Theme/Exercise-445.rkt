;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-445) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 445.
;; Use poly to formulate a check-satisfied test for find-root.
;; Also use poly to illustrate the root-finding process.


(require 2htdp/image)


(bitmap "./images/poly.png")


;; Number -> Number
;; Defines a binomial with two roots: 2 and 4.
(check-expect (poly 2) 0)
(check-expect (poly 4) 0)
(define (poly x)
  (* (- x 2) (- x 4)))

;; [Number -> Number] Number Number -> Number
;; Determines R such that f has a root in [R,(+ R EPSILON)].
;; Assume that:
;; - f is continuous
;; - (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left))) (2).
;; Divides interval in half, the root is in
;; one of the two halves, picks according to (2).
(check-within (find-root poly 1 3) 2 0.001)
(check-within (find-root poly 3 5) 4 0.001)
(check-satisfied (find-root poly 3 5) (lambda (n) (zero? (poly (round n)))))
(define (find-root f left right) 0)


#|
For interval [3,6] and EPSILON=0
|-------------------------------------------------------|
| step | left | f left | right | f right | mid  | f mid |
|-------------------------------------------------------|
| n=1  |   3  |   -1   |  6.00 |  8.00   | 4.50 | 1.25  |
|-------------------------------------------------------|
| n=2  |   3  |   -1   |  4.50 |  1.25   | 3.75 |-0.4375|
|-------------------------------------------------------|
|#
(poly 3) ;= -1
(poly 6) ;= 8
(poly 1.25) ;= 2.0625
(poly 3.75) ;= -0.4375

