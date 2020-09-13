;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-462) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 462.
;; Design the function check-solution.
;; It consumes an SOE and a Solution.
;; Its result is #true if plugging in the numbers from the Solution
;; for the variables in the Equations of the SOE produces
;; equal left-hand-side values and right-hand-side values;
;; otherwise the function produces #false.


;; An SOE (system of equations) is a non-empty Matrix.
;; Constraint: for (list r1 ... rn), (length ri) is (+ n 1).
;; Interpretation: represents a system of linear equations.

;; An Equation is a [List-of Number].
;; Constraint: an Equation contains at least two numbers.
;; Interpretation: if (list a1 ... an b) is an Equation,
;; a1, ..., an are the left-hand-side variable coefficients
;; and b is the right-hand side.

;; A Solution is a [List-of Number]


(define ERR-SIZE "Equation and Solution size does not match")

(define M ; an SOE
  (list (list 2 2  3 10) ; an Equation
        (list 2 5 12 31)
        (list 4 1 -2  1)))

(define S '(1 1 2)) ; a Solution

;; Equation -> [List-of Number]
;; Extracts the left-hand side from a row in a matrix.
(check-expect (lhs (first M)) '(2 2 3))
(define (lhs e)
  (reverse (rest (reverse e))))

;; Equation -> Number
;; Extracts the right-hand side from a row in a matrix.
(check-expect (rhs (first M)) 10)
(define (rhs e)
  (first (reverse e)))

;; SOE Solution -> Boolean
;; Determines whether s is a solution to soe.
(check-expect (check-solution M S) #true)
(check-expect (check-solution M '(0 0 0)) #false)
(check-expect (check-solution M '(1 2 3)) #false)
(define (check-solution soe s)
  (andmap (lambda (e)
            (= (foldr (lambda (v x r) (+ (* v x) r)) 0 (lhs e) s)
               (rhs e)))
          soe))

;; SOE Solution -> Boolean
;; Determines whether s is a solution to soe.
;; Produces an error if the solution format is invalid.
(check-error (check-solution-err M '()) ERR-SIZE)
(check-error (check-solution-err M '(1 2 3 4)) ERR-SIZE)
(check-expect (check-solution-err M S) #true)
(check-expect (check-solution-err M '(0 0 0)) #false)
(check-expect (check-solution-err M '(1 2 3)) #false)
(define (check-solution-err soe s)
  (local ((define len-solution (length s))
          ;; Equation -> Boolean
          (define (for-equation e)
            (local ((define vars (lhs e)))
              (if (= (length vars) len-solution)
                  (= (foldr (lambda (v x r) (+ (* v x) r)) 0 vars s)
                     (rhs e))
                  (error ERR-SIZE)))))
    (andmap for-equation soe)))

