;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-75) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 75.
;; Enter "UFO" definitions and their test cases
;; into the definitions area of DrRacket and make sure they work.


;;; Data Definitions

(define-struct vel [deltax deltay])
;; A Vel is a structure:
;; (make-vel Number Number).
;; (make-vel dx dy) means a velocity of
;; dx pixels [per tick] along the horizontal and
;; dy pixels [per tick] along the vertical direction.

(define-struct ufo [loc vel])
;; A UFO is a structure:
;; (make-ufo Posn Vel).
;; (make-ufo p v) is at location p,
;; moving at velocity v.


;;; Constants

(define v1 (make-vel 8 -3))
(define v2 (make-vel -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))


;;; Functions

;; UFO -> UFO
;; Determines where u moves in one clock tick and
;; leaves the velocity as is.
(check-expect (ufo-move-1 u1) u3)
(check-expect (ufo-move-1 u2)
              (make-ufo (make-posn 17 77) v2))
(define (ufo-move-1 u)
  (make-ufo (posn+ (ufo-loc u) (ufo-vel u))
            (ufo-vel u)))

;; Posn Vel -> Posn
;; Adds v to p.
(check-expect (posn+ p1 v1) p2)
(check-expect (posn+ p1 v2) (make-posn 17 77))
(define (posn+ p v)
  (make-posn (+ (posn-x p) (vel-deltax v))
             (+ (posn-y p) (vel-deltay v))))


;;; Application

;; (ufo-move-1 u3)
;; (ufo-move-1 u4)

