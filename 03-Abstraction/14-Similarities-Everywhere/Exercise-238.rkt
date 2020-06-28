;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-238) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 238.
;; Abstract the two functions in figure 89 into a single function.
;; Define inf-1 and sup-1 in terms of the abstract function.
;; Modify the original functions with the use of max,
;; which picks the larger of two numbers,
;; and min, which picks the smaller one.
;; Then abstract again, define inf-2 and sup-2, and test them with the same inputs again.


;; An Nelon is a non-empty list of Numbers.


(define test-list-1
  (list 25 24 23 22 21 20 19 18 17 16 15 14 13
        12 11 10 9 8 7 6 5 4 3 2 1))

(define test-list-2
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
        17 18 19 20 21 22 23 24 25))


;; Nelon Operator -> Number
;; Determines the extremum number on l.
(define (extremum-1 op l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (if (op (first l) (extremum-1 op (rest l)))
         (first l)
         (extremum-1 op (rest l)))]))

;; Nelon -> Number
;; Determines the smallest number on l.
(check-expect (inf-1 '(5)) 5)
(check-expect (inf-1 '(5 3 8)) 3)
(define (inf-1 l)
  (extremum-1 < l))

;; Nelon -> Number
;; Determines the largest number on l.
(check-expect (sup-1 '(5)) 5)
(check-expect (sup-1 '(5 3 8)) 8)
(define (sup-1 l)
  (extremum-1 > l))


;; Nelon -> Number
;; Determines the smallest number on l.
(check-expect (inf-min '(5)) 5)
(check-expect (inf-min '(5 3 8)) 3)
(define (inf-min l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (min (first l) (inf-min (rest l)))]))

;; Nelon -> Number
;; Determines the largest number on l.
(check-expect (sup-max '(5)) 5)
(check-expect (sup-max '(5 3 8)) 8)
(define (sup-max l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (max (first l) (sup-max (rest l)))]))

;; Nelon Function -> Number
;; Determines the extremum number on l.
(check-expect (extremum-2 min '(5 3 8)) 3)
(check-expect (extremum-2 max '(5 3 8)) 8)
(define (extremum-2 f l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (f (first l) (extremum-2 f (rest l)))]))

;; Nelon -> Number
;; Determines the smallest number on l.
(check-expect (inf-2 '(5)) 5)
(check-expect (inf-2 '(5 3 8)) 3)
(define (inf-2 l)
  (extremum-2 min l))

;; Nelon -> Number
;; Determines the largest number on l.
(check-expect (sup-2 '(5)) 5)
(check-expect (sup-2 '(5 3 8)) 8)
(define (sup-2 l)
  (extremum-2 max l))


;;; Application

;(extremum-2 min test-list-1)

;(extremum-2 max test-list-2)


;;; Answer
;; inf-2 and sup-2 perform a significantly smaller number of operations.

