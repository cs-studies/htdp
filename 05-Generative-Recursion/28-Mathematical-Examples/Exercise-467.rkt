;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-467) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 467.
;; Revise the algorithm triangulate from exercise 466
;; so that it rotates the equations first
;; to find one with a leading coefficient that is not 0
;; before it subtracts the first equation from the remaining ones.


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
(check-expect (triangulate (list (list 2  3  3 8)
                                 (list 2  3 -2 3)
                                 (list 4 -2  2 4)))
              (list (list 2  3  3 8)
                    (list   -8 -4 -12)
                    (list      -5 -5)))
(define (triangulate m)
  (cond
    [(empty? (rest m)) (list (first m))]
    [else
     (local ((define rotated
               (sort m (lambda (x y) (> (length x) (length y)))))
             (define first-r (first rotated))
             (define (subtract* e1 e2)
               (local ((define len-diff (- (length e1) (length e2))))
                 (if (> len-diff 0)
                     (subtract e1 (append (make-list len-diff 0) e2))
                     (subtract e1 e2)))))
       (cons first-r
             (triangulate
              (map (lambda (e2) (subtract* first-r e2)) (rest rotated)))))]))

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
                    (local ((define subtracted (- i2 (* i1 times))))
                      (if (zero? subtracted) l (cons subtracted l))))
                  '()
                  (rest e1)
                  (rest e2))
           (error ERR-REMAINDER)))]))


;;; Does this algorithm terminate for all possible system of equations?
;; Yes, with the provided error handling.

