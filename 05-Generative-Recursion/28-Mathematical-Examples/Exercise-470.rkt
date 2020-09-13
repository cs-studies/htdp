;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-470) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 470.
;; Define gauss,
;; which combines the triangulate function from exercise 468
;; and the solve function from exercise 469.

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


(define ERR-REMAINDER "Not supported")

(define ERR-ZEROS "All leading coefficients are 0")


;; SOE -> Solution
;; Solves a system of equations.
(check-expect (gauss (list (list 2 2 3 10)
                           (list 2 5 12 31)
                           (list 4 1 -2 1)))
              '(1 1 2))
(check-expect (gauss (list (list 2 3 3 8)
                           (list 2 3 -2 3)
                           (list 4 -2 2 4)))
              '(1 1 1))
(define (gauss m)
  (solve (triangulate m)))

;; SOE -> TM
;; Triangulates the given system of equations.
(check-expect (triangulate (list (list 2  3  3 8)
                                 (list 2  3 -2 3)
                                 (list 4 -2  2 4)))
              (list (list 2  3  3 8)
                    (list   -8 -4 -12)
                    (list      -5 -5)))
(check-error (triangulate (list (list 2  2 2 6)
                                (list 2 2 4 8)
                                (list 2 2 1 2))) ERR-ZEROS)
(check-error (triangulate (list (list 2 2) (list 5 6))) ERR-REMAINDER)
(define (triangulate m)
  (cond
    [(empty? (rest m)) (list (first m))]
    [else
     (local (
             (define (subtract e1 e2)
               (local ((define times (/ (first e2) (first e1))))
                 (if (integer? times)
                     (foldr (lambda (i1 i2 l)
                              (local ((define subtracted (- i2 (* i1 times))))
                                (if (zero? subtracted) l (cons subtracted l))))
                            '()
                            (rest e1)
                            (rest e2))
                     (error ERR-REMAINDER))))

             (define rotated
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


;; TM -> Solution
;; Solves triangular system of equations.
(check-expect (solve (list (list -2 1 -2 -10)
                           (list 3 3 21)
                           (list 2 10))) '(1 2 5))
(check-expect (solve (list (list 2 3 3 8)
                           (list  -8 -4 -12)
                           (list     -5 -5))) '(1 1 1))
(define (solve m)
  (local ((define (solve-each e l)
            (local ((define lhs (reverse (rest (reverse e))))
                    (define rhs (first (reverse e)))
                    (define known
                      (foldr (lambda (c v t) (+ (* c v) t))
                             0 (rest lhs) l)))
              (cons (/ (- rhs known) (first lhs)) l))))
    (foldr solve-each '() m)))

