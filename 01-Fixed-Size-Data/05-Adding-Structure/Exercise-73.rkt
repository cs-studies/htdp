;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-73) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 73.
;; Design the function posn-up-x, which consumes a Posn p and a Number n.
;; It produces a Posn like p with n in the x field.

(require 2htdp/image)
(require 2htdp/universe)


;;; Constants

(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))


;;; Data Definitions

;; A Posn represents the state of the world.


;;; Functions

;; Posn -> Posn
(define (main p0)
  (big-bang p0
    [on-tick x+]
    [to-draw scene+dot]))

;; Posn -> Image
;; Add a red spot to MTS at p.
(check-expect (scene+dot (make-posn 10 20))
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73))
              (place-image DOT 88 73 MTS))
(define (scene+dot p) (place-image DOT (posn-x p) (posn-y p) MTS))

;; Posn -> Posn
;; Increase the x-coordinate of p by 3.
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))
(define (x+ p)
  (posn-up-x p (+ (posn-x p) 3)))

;; Posn Number -> Posn
;; Sets the value of the x-coordinate of p to n.
(check-expect (posn-up-x (make-posn 10 15) 5) (make-posn 5 15))
(define (posn-up-x p n)
  (make-posn n (posn-y p)))


;;; Application

;; (main (make-posn 20 40))

