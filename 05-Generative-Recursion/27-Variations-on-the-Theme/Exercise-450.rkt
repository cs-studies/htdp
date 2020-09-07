;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-450) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 450.
;; A function f is monotonically increasing
;; if (<= (f a) (f b)) holds whenever (< a b) holds.
;; Simplify find-root assuming the given function is not only continuous
;; but also monotonically increasing.


(require 2htdp/image)


(bitmap "./images/mi.png")


(define EPSILON 0.001)

(define ERR-IVT
  "f(left) and f(right) must be on opposite sides of the x-axis")


;; Number -> Number
;; Defines a monotonically increasing function
;; with one root: -2.
(check-expect (mi -2) 0)
(check-expect (mi 2) 4)
(check-expect (mi 4) 6)
(define (mi x)
  (+ x 2))

;; [Number -> Number] Number Number -> Number
;; Determines R such that f has a root in [R,(+ R EPSILON)].
;; Assume that:
;; - f is continuous
;; - f is monotonically increasing.
;; Divides interval in half, the root is in
;; one of the two halves, picks according to (2).
(check-within (find-root mi -4 -1) -2 0.001)
(check-within (find-root mi -2 5) -2 0.001)
(check-error (find-root mi 1 10) ERR-IVT)
(define (find-root f left right)
  (local (
          (define (valid? l r)
            (and (<= (f l) 0)
                 (>= (f r) 0)))

          (define (find-root-acc l r valid)
            (local (
                    (define mid (/ (+ l r) 2))
                    (define f@m (f mid)))
              (if (not valid)
                  (error ERR-IVT)
                  (cond
                    [(<= (- r l) EPSILON) l]
                    [else
                     (if (>= f@m 0)
                         (find-root-acc l mid (valid? l mid))
                         (find-root-acc mid r (valid? mid r)))])))))
    (find-root-acc left right (valid? left right))))

