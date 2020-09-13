;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-466) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 466.
;; Design the triangulate algorithm.


;; An SOE (system of equations) is a non-empty Matrix.
;; Constraint: for (list r1 ... rn), (length ri) is (+ n 1).
;; Interpretation: represents a system of linear equations.

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

(define M ; an SOE
  (list (list 2 2  3 10) ; an Equation
        (list 2 5 12 31)
        (list 4 1 -2  1)))

(define TM (list (list 2 2 3 10)
                 (list   3 9 21)
                 (list     1  2)))


(define ERR-LENGTH "e1 and e2 must be of equal length")

(define ERR-REMAINDER "Not supported (yet)")


;; SOE -> TM
;; Triangulates the given system of equations.
(check-expect (triangulate (list (list 2 2 3 10)))
              (list (list 2 2 3 10)))
(check-expect (triangulate (list (list 2 2 3 10)
                                 (list 2 5 12 31)))
              (list (list 2 2 3 10)
                    (list   3 9 21)))
(check-expect (triangulate M) TM)
(define (triangulate m)
  (local ((define first-m (first m)))
    (cond
      [(empty? (rest m)) (list first-m)]
      [else (cons first-m
                  (triangulate
                   (map (lambda (e2) (subtract first-m e2)) (rest m))))])))


;; Equation Equation -> Equation
;; Produces the rest of the list
;; that results from the subtraction of e1 from e2.
;; (Subtracts until e2 has 0 in the first position.)
(check-expect (subtract '(2 2) '(2 5)) '(3))
(check-expect (subtract '(2 2 3 10) '(2 5 12 31)) '(3 9 21))
(check-expect (subtract '(3 9 21) '(-3 -8 -19)) '(1 2))
(check-error (subtract '(2 2) '(5 6 7)) ERR-LENGTH)
(check-error (subtract '(2 2) '(5 6)) ERR-REMAINDER)
(define (subtract e1 e2)
  (cond
    [(not (= (length e1) (length e2))) (error ERR-LENGTH)]
    [else
     (local ((define times (/ (first e2) (first e1))))
       (if (integer? times)
           (foldr (lambda (i1 i2 l)
                    (cons (- i2 (* i1 times)) l))
                  '()
                  (rest e1)
                  (rest e2))
           (error ERR-REMAINDER)))]))


;;; What is a trivially solvable problem?
;; The problem is trivially solvable if SOE contains one equation.

;;; How are trivial solutions solved?
;; In that case, SOE cannot be simplified. Return it as a result.

;;; How does the algorithm generate new problems
;;; that are more easily solvable than the original one?
;;; Is there one new problem that we generate or are there several?
;; Otherwise, the given SOE contains at least two equations.
;; In that case, subtract the first equation from the rest of the equations.
;; Then generate new triangulation problem for the rest of the processed SOE.

;;; Is the solution of the given problem
;;; the same as the solution of (one of) the new problems?
;;; Or, do we need to combine the solutions
;;; to create a solution for the original problem?
;;; And, if so, do we need anything from the original problem data?
;; It then suffices to combine first equations
;; of all recursively solved triangulation problems into one list.

