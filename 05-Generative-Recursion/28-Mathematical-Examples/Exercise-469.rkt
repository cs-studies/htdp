;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-469) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 469.
;; Design the solve function.
;; It consumes triangular SOEs and produces a solution.


;; An Equation is a [List-of Number].
;; Constraint: an Equation contains at least two numbers.
;; Interpretation: if (list a1 ... an b) is an Equation,
;; a1, ..., an are the left-hand-side variable coefficients
;; and b is the right-hand side.

;; A Solution is a [List-of Number]

;; A TM is an [NEList-of Equation]
;; such that the Equations are of decreasing length:
;;   n + 1, n, n - 1, ..., 2.
;; Interpretation: represents a triangular matrix.


;; TM -> Solution
;; Solves triangular system of equations.
(check-expect (solve (list (list 2 10))) '(5))
(check-expect (solve (list (list 3 3 21)
                           (list 2 10)))
              '(2 5))
(check-expect (solve (list (list -2 1 -2 -10)
                           (list 3 3 21)
                           (list 2 10)))
              '(1 2 5))
(check-expect (solve (list (list 2 3 3 8)
                           (list  -8 -4 -12)
                           (list     -5 -5)))
              '(1 1 1))
(define (solve m)
  (local ((define (solve-each e l)
            (local ((define lhs (reverse (rest (reverse e))))
                    (define rhs (first (reverse e)))
                    (define known
                      (foldr (lambda (c v t) (+ (* c v) t))
                             0 (rest lhs) l)))
              (cons (/ (- rhs known) (first lhs)) l))))
    (foldr solve-each '() m)))

