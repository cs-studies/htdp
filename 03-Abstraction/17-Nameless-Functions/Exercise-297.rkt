;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-297) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 297.
;; Design the function distance-between.


;; Number Number Posn -> Number
;; Computes the distance between the points (x, y) and p.
(check-expect (distance-between 10 10 (make-posn 10 10)) 0)
(check-expect (distance-between 3 4 (make-posn 0 0)) 5)
(define (distance-between x y p)
  (sqrt (+ (expt (- x (posn-x p)) 2)
           (expt (- y (posn-y p)) 2))))

