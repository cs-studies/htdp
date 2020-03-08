;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-46) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 46.
;; Adjust the rendering function from exercise 45
;; so that it uses one cat image or the other
;; based on whether the x-coordinate is odd.

;; Notes:
;; Just for fun,
;; this animation uses 3 images
;; (4 animation steps)
;; based on modulo check.

(require 2htdp/universe)
(require 2htdp/image)

;; Unit Tests
(check-expect (render 50)
              (place-image cat1 50 Y-IMAGE (empty-scene CANVAS-WIDTH CANVAS-HEIGHT)))
(check-expect (render 160)
              (place-image cat2 160 Y-IMAGE (empty-scene CANVAS-WIDTH CANVAS-HEIGHT)))
(check-expect (render 180)
              (place-image cat3 180 Y-IMAGE (empty-scene CANVAS-WIDTH CANVAS-HEIGHT)))

(check-expect (calculate-x 50) 53)
(check-expect (calculate-x 1000) 453)

;; Definitions
(define cat1 (bitmap "./images/cat1.png"))
(define cat2 (bitmap "./images/cat2.png"))
(define cat3 (bitmap "./images/cat3.png"))
(define IMAGE-WIDTH (image-width cat1))
(define IMAGE-HEIGHT (image-height cat1))
(define CANVAS-WIDTH (* IMAGE-WIDTH 5))
(define CANVAS-HEIGHT (* IMAGE-HEIGHT 2))
(define Y-IMAGE (- CANVAS-HEIGHT (/ IMAGE-HEIGHT 2)))

;; WorldState -> Image
(define (render ws)
  (place-image
   (cond
     [(= 0 (animation-step ws)) cat1]
     [(= 1 (animation-step ws)) cat2]
     [(= 2 (animation-step ws)) cat1]
     [(= 3 (animation-step ws)) cat3])
   ws Y-IMAGE
   (empty-scene CANVAS-WIDTH CANVAS-HEIGHT)))

;; WorldState -> Number
;; Calculates animation step.
(define (animation-step ws)
  (modulo (round (/ ws 12)) 4))

;; WorldState -> WorldState
(define (calculate-x ws)
  (modulo
   (+ 3 ws)
   (round (+ CANVAS-WIDTH (/ IMAGE-WIDTH 2)))))

;; WorldState -> WorldState
(define (cat-prog ws)
  (big-bang ws
    [to-draw render]
    [on-tick calculate-x]))

;; Application
(cat-prog 0)

