;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-139) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 139.
;; Design the function pos?,
;; which consumes a List-of-numbers
;; and determines whether all numbers are positive numbers.
;; Also design checked-sum.


;; A List-of-numbers is one of:
;; – '()
;; – (cons Number List-of-numbers)


;; List-of-numbers -> Boolean
;; Determines whether all numbers in the list l are positive numbers.
(check-expect (pos? '()) #true)
(check-expect (pos? (cons 1 '())) #true)
(check-expect (pos? (cons 1 (cons 2 '()))) #true)
(check-expect (pos? (cons -1 '())) #false)
(check-expect (pos? (cons -1 (cons -2 '()))) #false)
(check-expect (pos? (cons -1 (cons 1 '()))) #false)
(check-expect (pos? (cons 1 (cons -1 '()))) #false)
#|
;; Template
(define (pos? l)
  (cond
    [(empty? l) ...]
    [else
     (... (first l) ...
      ... (pos? (rest l)) ...)]))
|#
(define (pos? l)
  (cond
    [(empty? l) #true]
    [else
     (and
      (> (first l) 0)
      (pos? (rest l)))]))


(define ERROR-MESSAGE "checked-sum expects a list of non-negative numbers")

;; List-of-numbers -> Number
;; Computes the sum of the non-negative numbers in the list.
;; Signals the error if the list contains negative numbers.
(check-expect (checked-sum '()) 0)
(check-expect (checked-sum (cons 20 '())) 20)
(check-expect (checked-sum (cons 20 (cons 30 '()))) 50)
(check-error (checked-sum (cons -1 '())) ERROR-MESSAGE)
(check-error (checked-sum (cons 1 (cons -1 '()))) ERROR-MESSAGE)
#|
;; Template
(define (checked-sum l)
  (cond
    [(empty? l) ...]
    [(< (first l) 0) (error ERROR-MESSAGE)]
    [else
     (... (first l) ...
      ... (checked-sum (rest l)) ...)]))
|#
(define (checked-sum l)
  (cond
    [(empty? l) 0]
    [(< (first l) 0) (error ERROR-MESSAGE)]
    [else
     (+
      (first l)
      (checked-sum (rest l)))]))


;;; Application

;(pos? (cons 5 '()))
;(pos? (cons -1 '()))

