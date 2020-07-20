;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-156) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 156.
;; Equip the program in figure 61 with tests and make sure it passes those.
;; Explain what main does. Then run the program via main.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; A List-of-numbers is one of:
;; – '()
;; – (cons Number List-of-numbers)

;; A ShotWorld is a List-of-numbers.
;; Each number on such a list
;; represents the y-coordinate of a shot.


;;; Constants

(define HEIGHT 80) ; distances in terms of pixels
(define WIDTH 100)
(define SHOTS-X (/ WIDTH 2))

(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))


;;; Functions

;; ShotWorld -> ShotWorld
;; Usage: (main '())
(define (main w0)
  (big-bang w0
    [on-tick tick-handler]
    [on-key key-handler]
    [to-draw render]))

;; ShotWorld -> Image
;; Adds the image of a shot for each y on the list w
;; at (SHOTS-X, y) to the background image.
(check-expect (render '()) BACKGROUND)
(check-expect (render (cons 9 '())) (place-image SHOT SHOTS-X 9 BACKGROUND))
(check-expect (render (cons 9 (cons 22 '())))
              (place-image SHOT SHOTS-X 9 (place-image SHOT SHOTS-X 22 BACKGROUND)))
(define (render w)
  (cond
    [(empty? w) BACKGROUND]
    [else (place-image SHOT SHOTS-X (first w) (render (rest w)))]))

;; ShotWorld -> ShotWorld
;; Moves each shot on w up by one pixel.
(check-expect (tick-handler '()) '())
(check-expect (tick-handler (cons 9 '())) (cons 8 '()))
(check-expect (tick-handler (cons 9 (cons 22 '()))) (cons 8 (cons 21 '())))
(define (tick-handler w)
  (cond
    [(empty? w) '()]
    [else (cons (sub1 (first w)) (tick-handler (rest w)))]))

;; ShotWorld KeyEvent -> ShotWorld
;; Adds a shot to the world
;; if the player presses the space bar.
(check-expect (key-handler '() "a") '())
(check-expect (key-handler '() " ") (cons HEIGHT '()))
(check-expect (key-handler (cons 9 '()) "a") (cons 9 '()))
(check-expect (key-handler (cons 9 '()) " ") (cons HEIGHT (cons 9 '())))
(define (key-handler w key)
  (if (key=? key " ") (cons HEIGHT w) w))


;;; Application

;(main '())

