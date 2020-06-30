;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-252) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 252.
;; Design fold2, which is the abstraction of the two functions in figure 94.
;; Compare this exercise with exercise 251.


(require 2htdp/image)


;; Graphical constants
(define emt (empty-scene 100 100))
(define dot (circle 3 "solid" "red"))

;; Posn Image -> Image
(define (place-dot p img)
  (place-image
   dot
   (posn-x p) (posn-y p)
   img))


;; [List-of ITEM] Function ITEM -> Number
;; Operates on values of l with the function g,
;; using on-empty value.
(check-expect (fold2 '() * 1) 1)
(check-expect (fold2 '(1) * 1) 1)
(check-expect (fold2 '(1 2) * 1) 2)
(check-expect (fold2 '() place-dot emt) emt)
(check-expect (fold2 (list (make-posn 1 2)) place-dot emt) (place-dot (make-posn 1 2) emt))
(check-expect (fold2 (list (make-posn 1 2) (make-posn 3 5)) place-dot emt)
              (place-dot (make-posn 1 2) (place-dot (make-posn 3 5) emt)))
(define (fold2 l g on-empty)
  (cond
    [(empty? l) on-empty]
    [else
     (g (first l)
        (fold2 (rest l) g on-empty))]))

