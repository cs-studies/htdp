;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-468) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 468.
;; Modify triangulate from exercise 467 so that it signals an error
;; if it encounters an SOE whose leading coefficients are all 0.


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

(define ERR-REMAINDER "Not supported")

(define ERR-ZEROS "All leading coefficients are 0")


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
(check-error (triangulate (list (list 2  2 2 6)
                                (list 2 2 4 8)
                                (list 2 2 1 2))) ERR-ZEROS)
(define (triangulate m)
  (cond
    [(empty? (rest m)) (list (first m))]
    [else
     (local ((define rotated
               (sort m (lambda (x y) (> (length x) (length y)))))

             (define first-r (first rotated))

             (define subtracted-len-valid (- (length first-r) 1))

             (define (subtract* e1 e2)
               (local ((define len-diff (- (length e1) (length e2))))
                 (if (> len-diff 0)
                     (subtract e1 (append (make-list len-diff 0) e2))
                     (subtract e1 e2))))

             (define subtracted
               (map (lambda (e2) (subtract* first-r e2)) (rest rotated))))

       (if (andmap (lambda (e) (< (length e) subtracted-len-valid)) subtracted)
           (error ERR-ZEROS)
           (cons first-r (triangulate subtracted))))]))

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

