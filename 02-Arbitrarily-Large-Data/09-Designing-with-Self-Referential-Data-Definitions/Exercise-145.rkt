;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-145) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 145.
;; Design the sorted>? predicate,
;; which consumes a NEList-of-temperatures
;; and produces #true if the temperatures are sorted in descending order.


;; A CTemperature is a Number greater than -272.

;; An NEList-of-temperatures is one of:
;; – (cons CTemperature '())
;; – (cons CTemperature NEList-of-temperatures)
;; Represents non-empty lists of Celsius temperatures.

;; NEList-of-temperatures -> Boolean
;; Determines if the temperatures are sorted in descending order.
(check-expect (sorted>? (cons 1 '())) #true)
(check-expect (sorted>? (cons 2 (cons 1 '()))) #true)
(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
#|
;; Template
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) ...]
    [else (... (first ne-l) ... (sorted>? (rest ne-l)) ...)]))
|#
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (and
           (> (first ne-l) (first (rest ne-l)))
           (sorted>? (rest ne-l)))]))

