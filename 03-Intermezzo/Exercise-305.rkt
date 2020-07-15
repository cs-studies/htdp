;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-305) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 305.
;; Use loops to define convert-euro. See exercise 267.


(require 2htdp/abstraction)


(define USD-EUR-RATE 1.06)

;; [List-of Number] -> [List-of Number]
;; Converts a list of US$ amounts into a list of € amounts.
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 1.06 21.2 106)) (list 1 20 100))
(define (convert-euro lon)
  (for/list ([n lon])
    (/ n USD-EUR-RATE)))

