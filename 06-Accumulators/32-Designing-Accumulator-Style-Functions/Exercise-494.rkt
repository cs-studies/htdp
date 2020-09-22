;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-494) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exertise 494.
;; Does the insertion sort> function from Auxiliary Functions that Recur
;; need an accumulator? If so, why? If not, why not?


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of l.
(check-expect (sort> '(1 2)) '(2 1))
(check-expect (sort> '(1 2 3)) '(3 2 1))
(check-expect (sort> '(3 1 2)) '(3 2 1))
(define (sort> l)
  (cond
    [(empty? l) '()]
    [(cons? l) (insert (first l) (sort> (rest l)))]))

;; Number [List-of Number] -> [List-of Number]
;; Inserts n into the sorted list of numbers l.
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))

;(time (sort> (build-list 1000 add1)))
;; size  1000  2000  5000
;; time    29    88  1002


;;; Answer
;; sort> traverses the result of its natural recursion
;; with an auxiliary recursive function insert,
;; so accumulator parameter usage has to be considered
;; with the function insert being an accumulator candidate.

;;; worst-case scenario
#|
(sort> '(1 2 3))
;=
(insert 1 (sort> '(2 3)))
;=
(insert 1 (insert 2 (sort> '(3))))
;=
(insert 1 (insert 2 (insert 3 (sort> '()))))
;=
(insert 1 (insert 2 (insert 3 '())))
;=
(insert 1 (insert 2 (cons 3 '())))
;=
(insert 1 (cons 3 (insert 2 '())))
;=
(insert 1 (cons 3 (cons 2 '())))
;=
(insert 1 (cons 3 (cons 2 '())))
;=
(cons 3 (insert 1 (cons 2 '())))
;=
(cons 3 (cons 2 (insert 1 '())))
;=
(cons 3 (cons 2 (cons 1 '())))
|#


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of l.
(check-expect (sort>.v2 '(1 2)) '(2 1))
(check-expect (sort>.v2 '(1 2 3)) '(3 2 1))
(check-expect (sort>.v2 '(3 1 2)) '(3 2 1))
(define (sort>.v2 l)
  (local ((define (sort>/acc unsorted sorted)
            (cond
              [(empty? unsorted) sorted]
              [else (sort>/acc
                     (rest unsorted)
                     (insert (first unsorted) sorted))])))
    (sort>/acc l '())))

;(time (sort>.v2 (build-list 5000 add1)))
;; size  1000  2000  5000 10000 100000
;; time     0     0     0     0     24

