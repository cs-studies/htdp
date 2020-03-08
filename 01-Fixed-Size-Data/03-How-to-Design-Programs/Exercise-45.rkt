;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-45) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 45.
;; Design a “virtual cat” world program
;; that continuously moves the cat from left to right.
;; Let’s call it cat-prog and let’s assume
;; it consumes the starting position of the cat.
;; Furthermore, make the cat move three pixels per clock tick.
;; Whenever the cat disappears on the right, it reappears on the left.

(require 2htdp/universe)
(require 2htdp/image)

;; Unit Tests
(check-expect (render 50)
              (place-image cat1 50 Y-IMAGE (empty-scene CANVAS-WIDTH CANVAS-HEIGHT)))
(check-expect (render 150)
              (place-image cat1 150 Y-IMAGE (empty-scene CANVAS-WIDTH CANVAS-HEIGHT)))

(check-expect (calculate-x 50) 53)
(check-expect (calculate-x 1000) 453)

;; Definitions
(define cat1 (bitmap "./images/cat1.png"))
(define IMAGE-WIDTH (image-width cat1))
(define IMAGE-HEIGHT (image-height cat1))
(define CANVAS-WIDTH (* IMAGE-WIDTH 5))
(define CANVAS-HEIGHT (* IMAGE-HEIGHT 2))
(define Y-IMAGE (- CANVAS-HEIGHT (/ IMAGE-HEIGHT 2)))
(define VELOCITY 3)

;; WorldState -> Image
(define (render ws)
  (place-image cat1 ws Y-IMAGE (empty-scene CANVAS-WIDTH CANVAS-HEIGHT)))

;; WorldState -> WorldState
(define (calculate-x ws)
  (modulo
   (+ VELOCITY ws)
   (round (+ CANVAS-WIDTH (/ IMAGE-WIDTH 2)))))

;; WorldState -> WorldState
(define (cat-prog ws)
  (big-bang ws
    [to-draw render]
    [on-tick calculate-x]))

;; Application
(cat-prog 0)

