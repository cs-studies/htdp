;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-463) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 463.
;; Check that the following system of equations
;; has the same solution as M.


;; An SOE (system of equations) is a non-empty Matrix.
;; Constraint: for (list r1 ... rn), (length ri) is (+ n 1).
;; Interpretation: represents a system of linear equations.

;; An Equation is a [List-of Number].
;; Constraint: an Equation contains at least two numbers.
;; Interpretation: if (list a1 ... an b) is an Equation,
;; a1, ..., an are the left-hand-side variable coefficients
;; and b is the right-hand side.

;; A Solution is a [List-of Number]


(define M ; an SOE
  (list (list 2 2  3 10) ; an Equation
        (list 2 5 12 31)
        (list 4 1 -2  1)))

(define S '(1 1 2)) ; a Solution

(define soe-1 (list (list 2 2 3 10)
                    (list 0 3 9 21)
                    (list 0 0 1 2)))


;; SOE Solution -> Boolean
;; Determines whether s is a solution to soe.
(check-expect (check-solution M S) #true)
(check-expect (check-solution M '(0 0 0)) #false)
(check-expect (check-solution M '(1 2 3)) #false)
(check-expect (check-solution soe-1 S) #true)
(define (check-solution soe s)
  (local ((define (lhs e)
            (reverse (rest (reverse e))))
          (define (rhs e)
            (first (reverse e))))
    (andmap (lambda (e)
              (= (foldr (lambda (v x r) (+ (* v x) r)) 0 (lhs e) s)
                 (rhs e)))
            soe)))


#|
2 * x + 2 * y + 3 * z = 10
0 * x + 3 * y + 9 * z = 21
0 * x + 0 * y + 1 * z = 2

2 * 1 + 2 * 1 + 3 * 2 = 10
0 * 1 + 3 * 1 + 9 * 2 = 21
0 * 1 + 0 * 1 + 1 * 2 = 2

2 * 1 + 2 * 1 + 3 * 2 = 10
        3 * 1 + 9 * 2 = 21
                1 * 2 = 2
|#

