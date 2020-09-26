;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-511) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 511.
;; Explain the scope of each binding occurrence in the above examples.
;; Draw arrows from the bound to the binding occurrences.


#|
(λ (x) x)
(λ (x) <- x)

(λ (x) y)
y is a free variable

(λ (y) (λ (x) y))
    ^         |
    |         |
    *---------*

((λ (x) x) (λ (x) x))
((λ (x) <- x) (λ (x) <- x))

((λ (x) (x x)) (λ (x) (x x)))

(((λ (y) (λ (x) y)) (λ (z) <- z)) (λ (w) <- w))
      ^         |
      |         |
      *---------*
|#

