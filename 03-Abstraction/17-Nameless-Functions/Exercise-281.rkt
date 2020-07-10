;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-281) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 281.
;; Write down a lambda expression that:


;; consumes a number and decides whether it is less than 10;
(define l1
  (lambda (n) (< n 10)))
(check-expect (l1 5) #true)
(check-expect (l1 10) #false)


;; multiplies two given numbers and turns the result into a string;
(define l2
  (lambda (n m) (number->string (* n m))))
(check-expect (l2 1 2) "2")
(check-expect (l2 5 10) "50")


;; consumes a natural number and returns 0 for evens and 1 for odds;
(define l3
  (lambda (n) (if (even? n) 0 1)))
(check-expect (l3 2) 0)
(check-expect (l3 5) 1)


;; consumes two inventory records and compares them by price;
(define-struct ir [name price])
(check-expect
 ((lambda (ir1 ir2) (> (ir-price ir1) (ir-price ir2)))
  (make-ir "Avocado" 1) (make-ir "Apple" 0.5))
 #true)


;; adds a red dot at a given Posn to a given Image.
(require 2htdp/image)
((lambda (p img)
  (place-image (circle 1 "solid" "green")
               (posn-x p) (posn-y p)
               img))
 (make-posn 10 5) (empty-scene 20 20 "yellow"))

