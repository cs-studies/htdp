;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-481) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 481.
;; Design the n-queens-solution? function,
;; which consumes a natural number n and produces a predicate on queen placements
;; that determines whether a given placement is a solution to an n queens puzzle
;; Design the function set=?.
;; It consumes two lists and determines
;; whether they contain the same items—regardless of order.


;;; Data Definitions and Constants

(define QUEENS 8)

;; N is one of:
;; - 0
;; - (add1 N)

;; A QP is a structure:
;;   (make-posn CI CI)

;; A CI is an N in [0,QUEENS).
;; interpretation (make-posn r c) denotes the square at
;; the r-th row and c-th column.


(define 4QUEEN-SOLUTION-1
  (list  (make-posn 0 1) (make-posn 1 3) (make-posn 2 0) (make-posn 3 2)))

(define 4QUEEN-SOLUTION-2
  (list  (make-posn 0 2) (make-posn 1 0) (make-posn 2 3) (make-posn 3 1)))


;;; Functions

;; N -> [Maybe [List-of QP]]
;; Finds a solution to the n queens problem.
;(check-expect (n-queens 2) #false)
;(check-expect (n-queens 3) #false)
(check-satisfied (n-queens 4) (n-queens-solution? 4))
(check-satisfied (n-queens 4) is-4queens-result?)
;(define (n-queens n) (place-queens (board0 n) n))
(define (n-queens n) (list (make-posn 0 1) (make-posn 1 3) (make-posn 2 0) (make-posn 3 2)))
;(define (n-queens n) (list (make-posn 0 1) (make-posn 1 3) (make-posn 1 3) (make-posn 3 2))

;; N -> [[List-of QP] -> Boolean]
;; Produces a predicate that determines whether
;; a given list of QP is a solution to an n-queens puzzle.
(define (n-queens-solution? n)
  (lambda (lop)
    (if (not (= (length lop) n))
        #false
        (foldr (lambda (q1 checked)
                 (local ((define q1-vs-qs
                           (andmap
                            (lambda (q2) (not (threatening? q1 q2)))
                            (remove q1 lop))))
                   (and q1-vs-qs checked)))
               #true
               lop))))

;; QP QP -> Boolean
;; Determines whether queens threaten each other.
(check-expect (threatening? (make-posn 0 0) (make-posn 1 2)) #false)
(check-expect (threatening? (make-posn 2 3) (make-posn 5 5)) #false)
(check-expect (threatening? (make-posn 2 3) (make-posn 2 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 6 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 1 2)) #true)
(define (threatening? q1 q2)
  (local ((define q1x (posn-x q1))
          (define q1y (posn-y q1))
          (define q2x (posn-x q2))
          (define q2y (posn-y q2)))
    (or (= q1x q2x)
        (= q1y q2y)
        (= (+ q1x q1y) (+ q2x q2y))
        (= (- q1x q1y) (- q2x q2y)))))


;; [List-of QP] -> Boolean
;; Determines whether the result equals [as a set] to one of two lists.
(define (is-4queens-result? x)
  (or (set=? 4QUEEN-SOLUTION-1 x)
      (set=? 4QUEEN-SOLUTION-2 x)))

;; [X] [List-of X] [List-of X] -> Boolean
;; Determines whether the given lists contain the same items.
(check-expect (set=? '() '()) #true)
(check-expect (set=? '() '(1)) #false)
(check-expect (set=? '(1) '(1)) #true)
(check-expect (set=? '(1 2 3) '(3 2 1)) #true)
(check-expect (set=? '(1 2 3) '(3 2 4)) #false)
(check-expect (set=? (list (make-posn 10 2)) (list (make-posn 10 2))) #true)
(check-expect (set=? (list (make-posn 10 2)) (list (make-posn 1 2))) #false)
(define (set=? l1 l2)
  (cond
    [(and (empty? l1) (empty? l2)) #true]
    [(not (= (length l1) (length l2))) #false]
    [else
     (local ((define item (first l1)))
       (if (member? item l2)
           (set=? (rest l1) (remove item l2))
           #false))]))

