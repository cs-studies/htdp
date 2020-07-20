;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-138) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 138.
;; The following data definition represents sequences of amounts of money.
;; Design the sum function.


;; A List-of-amounts is one of:
;; – '()
;; – (cons PositiveNumber List-of-amounts)
;; Represents sequences of amounts of money.

;; Examples:
;; '()
;; (cons 20 '())
;; (cons 20 (cons 30 '()))


;; List-of-amounts -> Number
;; Computes the sum of the amounts.
(check-expect (sum '()) 0)
(check-expect (sum (cons 20 '())) 20)
(check-expect (sum (cons 20 (cons 30 '()))) 50)
#|
;; Template
(define (sum amounts-list)
  (cond
    [(empty? amounts-list) ...]
    [else
     (... (first amounts-list) ...
      ... (sum (rest amounts-list)) ...)]))
|#
(define (sum amounts-list)
  (cond
    [(empty? amounts-list) 0]
    [else
     (+
      (first amounts-list)
      (sum (rest amounts-list)))]))


;;; Application

;(sum (cons 10 (cons 20 '())))

