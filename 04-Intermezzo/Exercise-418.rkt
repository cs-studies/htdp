;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-418) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 418.
;; Design my-expt without using expt.
;; The function raises the first given number
;; to the power of the second one, a natural number.


;; N is one of:
;; - 0
;; - (add1 N)

;; Number N -> Number
;; Raises n to the power of p.
(check-expect (my-expt 2 0) 1)
(check-expect (my-expt 2 1) 2)
(check-expect (my-expt 2 2) 4)
(check-expect (my-expt 2 3) 8)
(check-expect (my-expt 5 3) 125)
(define (my-expt n p)
  (cond
    [(= 0 p) 1]
    [else (* n (my-expt n (sub1 p)))]))


;;; Application

(define inex (+ 1 #i1e-12))
(define exac (+ 1 1e-12))

(my-expt inex 30)
;; #i1.0000000000300027
(my-expt exac 30)
;; 1.0000000000300000000004350...

