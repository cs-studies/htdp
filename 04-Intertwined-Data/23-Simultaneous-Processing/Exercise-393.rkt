;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-393) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 393.
;; Figure 62 presents two data definitions for finite sets.
;; Design the union function
;; for the representation of finite sets of your choice.
;; It consumes two sets and produces one that contains the elements of both.
;;
;; Design intersect for the same set representation.
;; It consumes two sets and produces the set
;; of exactly those elements that occur in both.


;; A Son is one of:
;; – empty
;; – (cons Number Son)
;; Constraint: if s is a Son, no number occurs twice in s.

;; Son Son -> Son
;; Produces a set that contains all elements from s1 and s2.
(check-expect (union '() '()) '())
(check-expect (union '(1) '()) '(1))
(check-expect (union '() '(2)) '(2))
(check-expect (union '(1) '(2)) '(1 2))
(check-expect (union '(1 2) '(2)) '(1 2))
(check-expect (union '(1) '(1 2)) '(1 2))
(check-expect (union '(1 2 3) '(0 3 4)) '(1 2 3 0 4))
(define (union s1 s2)
  (cond
    [(empty? s2) s1]
    [else (union (if (member? (first s2) s1)
                     s1
                     (append s1 (list (first s2))))
                 (rest s2))]))

;; Son Son -> Son
;; Produces a set that contains elements
;; occurring in both s1 and s2.
(check-expect (intersect '() '()) '())
(check-expect (intersect '(1) '()) '())
(check-expect (intersect '() '(2)) '())
(check-expect (intersect '(1) '(2)) '())
(check-expect (intersect '(1) '(1)) '(1))
(check-expect (intersect '(1 2) '(2)) '(2))
(check-expect (intersect '(1) '(1 2)) '(1))
(check-expect (intersect '(1 2 3) '(0 3 4)) '(3))
(define (intersect s1 s2)
  (cond
    [(empty? s2) '()]
    [else
     (local ((define intersection (intersect s1 (rest s2))))
       (if (member? (first s2) s1)
           (cons (first s2) intersection)
           intersection))]))

