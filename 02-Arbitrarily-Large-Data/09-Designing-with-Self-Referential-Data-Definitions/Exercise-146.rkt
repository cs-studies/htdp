;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-146) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 146.
;; Design how-many for NEList-of-temperatures.


;; A CTemperature is a Number greater than -272.

;; An NEList-of-temperatures is one of:
;; – (cons CTemperature '())
;; – (cons CTemperature NEList-of-temperatures)
;; Represents non-empty lists of Celsius temperatures.

;; NEList-of-temperatures -> Number
;; Computes the average temperature.
(check-expect (average (cons 0 '())) 0)
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)
 (define (average ne-l)
  (/ (sum ne-l)
     (how-many ne-l)))

;; NEList-of-temperatures -> Number
;; Adds up the temperatures on the given list.
(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)
(define (sum alot)
  (cond
    [(empty? (rest alot)) (first alot)]
    [else (+ (first alot) (sum (rest alot)))]))

;; NEList-of-temperatures -> Number
;; Counts the temperatures on the given list.
(check-expect (how-many (cons 10 '())) 1)
(check-expect (how-many (cons 10 (cons 5 '()))) 2)
(define (how-many alos)
  (cond
    [(empty? (rest alos)) 1]
    [else (+ (how-many (rest alos)) 1)]))

