;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-153) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 153.
;; Visualize the result of a 1968-style European student riot.


(require 2htdp/image)


;;; Data Definitions

;; An N is one of:
;; – 0
;; – (add1 N)
;; Represents the counting numbers.

;; A List-of-posns is one of:
;; - '()
;; - (cons Posn List-of-posns)


;;; Constants

(define SQUARE-SIZE 10)
(define SQUARE (square SQUARE-SIZE "outline" "black"))
(define DOT (circle 2 "solid" "red"))
(define HALL-COLS 8)
(define HALL-ROWS 18)


;;; Functions

;; List-of-posns -> Image
;; Produces an images of the lecture hall
;; with red dots specified by the list l.
(check-expect (add-baloons '()) (draw-hall HALL-COLS HALL-ROWS))
(check-expect (add-baloons (cons (make-posn 10 50) (cons (make-posn 60 170) '())))
              (place-image DOT 10 50 (place-image DOT 60 170 (draw-hall HALL-COLS HALL-ROWS))))
(define (add-baloons l)
  (cond
    [(empty? l) (draw-hall HALL-COLS HALL-ROWS)]
    [else (place-image
           DOT
           (posn-x (first l))
           (posn-y (first l))
           (add-baloons (rest l)))]))

;; N N -> Image
;; Creates a rectangle of c by r squares.
(check-expect (draw-hall 2 3)
              (place-image
               (above (beside SQUARE SQUARE) (beside SQUARE SQUARE) (beside SQUARE SQUARE))
               10 15
               (empty-scene 21 31 "white")))
(define (draw-hall c r)
  (place-image
   (row r (col c SQUARE))
   (/ (* SQUARE-SIZE c) 2) (/ (* SQUARE-SIZE r) 2)
   (empty-scene (+ 1 (* SQUARE-SIZE c)) (+ 1 (* SQUARE-SIZE r)) "white")))

;; N Image -> Image
;; Produces a column of n copies of img.
(check-expect (col 2 SQUARE) (beside SQUARE SQUARE))
(check-expect (col 0 SQUARE) empty-image)
(define (col n img)
  (cond
    [(zero? n) empty-image]
    [else (beside img (col (sub1 n) img))]))


;; N Image -> Image
;; Produces a row of n copies of img.
(check-expect (row 2 SQUARE) (above SQUARE SQUARE))
(check-expect (row 0 SQUARE) empty-image)
(define (row n img)
  (cond
    [(zero? n) empty-image]
    [else (above img (row (sub1 n) img))]))


;;; Application

;(add-baloons '())

;(add-baloons (cons (make-posn 10 50) (cons (make-posn 60 170) '())))

