;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-443) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 443.
;; Given the header material for gcd-structural,
;; a naive use of the design recipe might use
;; the following template or some variant:


(define (gcd-structural n m)
  (cond
    [(and (= n 1) (= m 1)) ...]
    [(and (> n 1) (= m 1)) ...]
    [(and (= n 1) (> m 1)) ...]
    [else
     (... (gcd-structural (sub1 n) (sub1 m)) ...
          ... (gcd-structural (sub1 n) m) ...
          ... (gcd-structural n (sub1 m)) ...)]))


;;; Why is it impossible to find a divisor with this strategy?
;; With the structural approach, the original n and m
;; must be tested on being evenly divisible by a candidate divisor.
;; The given template doesn't reflect a need in
;; having the original n and m available
;; - together with a new candidate divisor -
;; on each recursion step.
;; Moreover, the provided template doesn't show what should be used
;; as a valid candidate divisor on each step.
;; (gcd-structural (sub1 n) m) or (gcd-structural n (sub1 m))
;; gets a bit closer to the valid approach, but still misses a point
;; of choosing a smaller number to sub1 from.

