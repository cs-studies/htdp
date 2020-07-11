;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-285) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 285.
;; Use map to define the function convert-euro,
;; which converts a list of US$ amounts into a list of € amounts
;; based on an exchange rate of US$1.06 per €.
;;
;; Also use map to define convertFC,
;; which converts a list of Fahrenheit measurements to a list of Celsius measurements.
;;
;; Finally, try your hand at translate,
;; a function that translates a list of Posns into a list of lists of pairs of numbers.


(define USD-EUR-RATE 1.06)

;; [List-of Number] -> [List-of Number]
;; Converts a list of US$ amounts into a list of € amounts.
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 1.06 21.2 106)) (list 1 20 100))
(define (convert-euro lon)
  (map (lambda (n) (/ n USD-EUR-RATE)) lon))


;; [List-of Number] -> [List-of Number]
;; Converts a list of Fahrenheit measurements to a list of Celsius measurements.
(check-within (convertFC (list -40 0 80 100)) (list -40 -17.7 26.6 37.7) 0.1)
(define (convertFC lon)
  (map (lambda (n) (* 5/9 (- n 32))) lon))


;; [List-of Posn] -> [List-of [List Number Number]]
;; Translates a list of Posns into a list of lists of pairs of numbers.
(check-expect (translate (list (make-posn 0 80) (make-posn 100 40)))
              (list (list 0 80) (list 100 40)))
(define (translate lop)
    (map (lambda (p) (list (posn-x p) (posn-y p))) lop))

