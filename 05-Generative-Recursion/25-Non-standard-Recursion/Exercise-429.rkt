;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-429) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 429.
;; Use filter to define smallers and largers.


;; See exercise 428.
;; This example uses filter without defining additional functions.


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of alon.
(check-expect (quick-sort< '()) '())
(check-expect (quick-sort< '(1)) '(1))
(check-expect (quick-sort< (list 11 5 9 2 4)) (list 2 4 5 9 11))
(check-expect (quick-sort< (list 3 2 1 1 2 3)) (list 1 1 2 2 3 3))
(define (quick-sort< alon)
  (cond
    [(or (empty? alon) (empty? (rest alon))) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (filter (lambda (x) (< x pivot)) alon))
                    (filter (lambda (x) (= x pivot)) alon)
                    (quick-sort< (filter (lambda (x) (> x pivot)) alon))))]))

