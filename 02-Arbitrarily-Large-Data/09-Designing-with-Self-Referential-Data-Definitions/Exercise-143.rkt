;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-143) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 143.
;; Design checked-average function.


;; A List-of-temperatures is one of:
;; – '()
;; – (cons CTemperature List-of-temperatures)

;; A CTemperature is a Number greater than -272.

(define ERROR-MESSAGE "checked-average expects not empty list")

;; List-of-temperatures -> Number
;; Computes the average temperature.
(check-expect (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)
(check-error (checked-average '()) ERROR-MESSAGE)
(define (checked-average alot)
  (cond
    [(empty? alot) (error ERROR-MESSAGE)]
    [else (/ (sum alot) (how-many alot))]))

;; List-of-temperatures -> Number
;; Adds up the temperatures on the given list.
(check-expect
 (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(define (sum alot)
  (cond
    [(empty? alot) 0]
    [else (+ (first alot) (sum (rest alot)))]))

;; List-of-temperatures -> Number
;; Counts the temperatures on the given list.
(check-expect (how-many '()) 0)
(check-expect (how-many (cons 10 '())) 1)
(check-expect (how-many (cons 10 (cons 5 '()))) 2)
(define (how-many alos)
  (cond
    [(empty? alos) 0]
    [else (+ (how-many (rest alos)) 1)]))

