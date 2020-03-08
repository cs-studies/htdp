;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-64) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 64.
;; Design the function manhattan-distance,
;; which measures the Manhattan distance of the given posn to the origin.


;; Posn -> distance
(check-expect (manhattan-distance (make-posn 3 4)) 7)
(check-expect (manhattan-distance (make-posn 3 0)) 3)
(check-expect (manhattan-distance (make-posn 0 4)) 4)
(define (manhattan-distance p)
  (+ (posn-x p) (posn-y p)))

