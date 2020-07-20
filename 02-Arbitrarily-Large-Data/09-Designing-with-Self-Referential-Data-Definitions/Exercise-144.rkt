;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-144) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 144.
;; Will sum and how-many work for NEList-of-temperatures
;; even though they are designed for inputs from List-of-temperatures?


;; A List-of-temperatures is one of:
;; – '()
;; – (cons CTemperature List-of-temperatures)

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


;; Answer
;; sum and how-many are designed to work with any List-of-temperatures list.
;; NEList-of-temperatures is a subset of List-of-temperatures.
;; Hence the functions sum and how-many work for NEList-of-temperatures.

