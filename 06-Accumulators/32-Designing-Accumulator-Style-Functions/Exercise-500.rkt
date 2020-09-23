;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-500) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 500.
;; Design an accumulator-style version of how-many,
;; which is the function that determines the number of items on a list.


;; [X] [List-of X] -> Number
;; Calculates the number of items on the given list.
(check-expect (how-many '()) 0)
(check-expect (how-many '(10)) 1)
(check-expect (how-many '(10 20 30)) 3)
(define (how-many l0)
  (local (;; [List-of X] Number -> Number
          ;; Calculates the number of items on l.
          ;; Accumulator a is a number of items on l0
          ;; that are not on l.
          (define (how-many/acc l a)
            (cond
              [(empty? l) a]
              [else (how-many/acc (rest l) (add1 a))])))
    (how-many/acc l0 0)))


;;; The performance of how-many is O(n) where n is the length of the list.
;;; Does the accumulator version improve on this?
;; Yes, the performance is reduced to O(1).

;;; Does the accumulator reduce the amount of space needed to compute the result?
;; Yes, by the means of tail-call optimization.

