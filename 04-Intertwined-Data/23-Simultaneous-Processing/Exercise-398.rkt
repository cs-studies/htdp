;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-398) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 398.
;; Design value.
;; The function consumes two equally long lists:
;; a linear combination and a list of variable values.
;; It produces the value of the combination for these values.


;; [List-of Number] [List-of Number] -> Number
;; Produces the value of the linear combination
;; for the coefficients and values on the lists l1 and l2.
(check-expect (value '() '()) 0)
(check-expect (value '(5) '(2)) 10)
(check-expect (value '(5 17) '(2 10)) (+ 10 170))
(check-expect (value '(5 17 8) '(3 5 4)) (+ (* 5 3) (* 17 5) (* 8 4)))
(define (value l1 l2)
  (cond
    [(empty? l1) 0]
    [else (+
           (* (first l1) (first l2))
           (value (rest l1) (rest l2)))]))

