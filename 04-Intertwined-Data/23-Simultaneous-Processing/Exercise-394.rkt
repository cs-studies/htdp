;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-394) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 394.
;; Design merge.
;; The function consumes two lists of numbers,
;; sorted in ascending order.
;; It produces a single sorted list of numbers
;; that contains all the numbers on both inputs lists.
;; A number occurs in the output as many times
;; as it occurs on the two input lists together.


;; A Lon is a [List-of Number] sorted in ascending order.

;; Lon Lon -> Lon
;; Produces a Lon that contains all the numbers
;; on both inputs lists.
(check-expect (merge '() '()) '())
(check-expect (merge '(1) '()) '(1))
(check-expect (merge '() '(2)) '(2))
(check-expect (merge '(1) '(2)) '(1 2))
(check-expect (merge '(2) '(1)) '(1 2))
(check-expect (merge '(1) '(2)) '(1 2))
(check-expect (merge '(1 2) '(2 3)) '(1 2 2 3))
(check-expect (merge '(3 4 6) '(1 2 5 6)) '(1 2 3 4 5 6 6))
(define (merge l1 l2)
  (cond
    [(empty? l2) l1]
    [(empty? l1) l2]
    [else
     (if (<= (first l2) (first l1))
         (cons (first l2) (merge l1 (rest l2)))
         (cons (first l1) (merge (rest l1) l2)))]))

