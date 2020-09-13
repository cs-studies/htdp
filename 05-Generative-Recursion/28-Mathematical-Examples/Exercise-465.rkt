;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-465) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 465.
;; Design subtract.
;; The function consumes two Equations of equal length.
;; It “subtracts” a multiple of the second equation from the first,
;; item by item, so that the resulting Equation has a 0 in the first position.
;; Since the leading coefficient is known to be 0,
;; subtract returns the rest of the list that results from the subtractions.


;; An SOE (system of equations) is a non-empty Matrix.
;; Constraint: for (list r1 ... rn), (length ri) is (+ n 1).
;; Interpretation: represents a system of linear equations.

;; An Equation is a [List-of Number].
;; Constraint: an Equation contains at least two numbers.
;; Interpretation: if (list a1 ... an b) is an Equation,
;; a1, ..., an are the left-hand-side variable coefficients
;; and b is the right-hand side.

;; A Solution is a [List-of Number]


(define ERR-LENGTH "e1 and e2 must be of equal length")

(define ERR-REMAINDER "Not supported (yet)")


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

