;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-105) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 105.
;; Some program contains the following data definition.
;; Make up at least two data examples per clause in the data definition.


;;; Data Definitions

;; A Coordinate is one of:
;; – a NegativeNumber
;; interpretation on the y axis, distance from top
;; – a PositiveNumber
;; interpretation on the x axis, distance from left
;; – a Posn
;; interpretation an ordinary Cartesian point


;;; Application

(define coord-y1 -30)
(define coord-y2 -10)

(define coord-x1 15)
(define coord-x2 40)

(define coord-p1 (make-posn 20 25))
(define coord-p2 (make-posn 45 17))

