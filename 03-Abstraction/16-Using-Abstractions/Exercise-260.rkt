;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-260) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 260.
;; Confirm the insight about the performance of inf.v2
;; by repeating the performance experiment of exercise 238.


;; An Nelon is a non-empty list of Numbers.

(define test-list-sm '(5 3 25))

(define test-list-1
  (list 25 24 23 22 21 20 19 18 17 16 15 14 13
        12 11 10 9 8 7 6 5 4 3 2 1))

(define test-list-2
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
        17 18 19 20 21 22 23 24 25))


;; Nelon -> Number
;; Determines the smallest number on l.
;; SLOW!
(define (inf l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (if (< (first l)
            (inf (rest l)))
         (first l)
         (inf (rest l)))]))

;; Nelon -> Number
;; Determines the smallest number on l.
(define (inf.v2 l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local ((define smallest-in-rest (inf.v2 (rest l))))
       (if (< (first l) smallest-in-rest)
           (first l)
           smallest-in-rest))]))


;;; Application

;(inf test-list-1) ; SLOW!

;(inf.v2 test-list-1) ; Good performance

