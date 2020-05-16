;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-164) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 164.
;; Design the function convert-euro, which converts a list of US$ amounts into a list of € amounts.


;; A List-of-numbers is one of:
;; - '()
;; - (cons Number List-of-numbers)

(define RATE 0.9242) ; 1 USD = 0.9242 EUR

;; List-of-numbers -> List-of-numbers
;; Converts a list of USD amounts into a list of EUR amounts.
(check-expect (to-euro '()) '())
(check-expect (to-euro (cons 0 (cons 32 (cons 100 '()))))
                         (cons (* RATE 0) (cons (* RATE 32) (cons (* RATE 100) '()))))
#|
;; Template
(define (to-euro usd)
  (cond
    [(empty? usd) ...]
    [else (... (first usd) ... (to-euro (rest usd)) ...)]))
|#
(define (to-euro usd)
  (cond
    [(empty? usd) '()]
    [else (cons (* (first usd) RATE) (to-euro (rest usd)))]))

