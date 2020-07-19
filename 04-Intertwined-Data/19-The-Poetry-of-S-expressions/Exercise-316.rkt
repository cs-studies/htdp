;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-316) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 316.
;; Define atom? function.


;; An Atom is one of:
;; – Number
;; – String
;; – Symbol

;; Any -> Boolean
;; Determines whether any is Atom.
(check-expect (atom? '()) #false)
(check-expect (atom? #true) #false)
(check-expect (atom? 10) #true)
(check-expect (atom? "a") #true)
(check-expect (atom? 'x) #true)
(define (atom? any)
  (or
   (number? any)
   (string? any)
   (symbol? any)))

