;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-126) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 126.
;; Identify the values among the following expressions,
;; assuming the definitions area contains these structure type definitions:

(define-struct point [x y z])
(define-struct none  [])


(make-point 1 2 3)
;; value
;; structure point


(make-point (make-point 1 2 3) 4 5)
;; value
;; structure point


(make-point (+ 1 2) 3 4)
;; value
;; structure point
;; == (make-point 3 3 4)


(make-none)
;; value
;; structure none


(make-point (point-x (make-point 1 2 3)) 4 5)
;; value
;; structure point
;; == (make-point 1 4 5)

