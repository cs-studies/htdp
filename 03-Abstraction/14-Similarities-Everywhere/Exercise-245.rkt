;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-245) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 245.
;; Develop the function=at-1.2-3-and-5.775? function.
;; Can we hope to define function=?,
;; which determines whether two functions from numbers to numbers are equal?


;; Function Function -> Boolean
;; Determines whether x and y produce the same results for 1.2, 3, and -5.775.
(check-expect (function=at-1.2-3-and-5.775? add1 add1) #true)
(check-expect (function=at-1.2-3-and-5.775? add1 sub1) #false)
(define (function=at-1.2-3-and-5.775? x y)
  (and (= (x 1.2) (y 1.2))
       (= (x 3) (y 3))
       (= (x 5.775) (y 5.775))))


;;; Answer.
;; No, it is not possible.
;; First, we cannot test two functions results on all possible numbers.
;; Second, the halting problem arises considering such a comparing function function=?.

