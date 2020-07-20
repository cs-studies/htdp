;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-44) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 44.
;; If the mouse is clicked anywhere on the canvas,
;; the car is placed at the x-coordinate of that click.
;;
;; A WorldState is a Number.
;; ws (world state) is the number of pixels between
;; the left border of the scene and the car.

(require 2htdp/universe)
(require 2htdp/image)

;; Unit tests
(check-expect (render 50) (place-image CAR 50 Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR 200 Y-CAR BACKGROUND))

(check-expect (tick-handler 20) (+ VELOCITY 20))
(check-expect (tick-handler 78) (+ VELOCITY 78))

(check-expect (hyper 21 10 20 "enter") 21)
(check-expect (hyper 42 10 20 "button-down") 10)
(check-expect (hyper 42 10 20 "move") 42)

(check-expect (end? (+ X-CAR-STOP 1)) #true)
(check-expect (end? 30) #false)


;; Definitions
(define WHEEL-RADIUS 5) ; Single point of control over the rendered image sizes.
(define WHEEL-DIAMETER (* WHEEL-RADIUS 2))
(define VELOCITY (/ WHEEL-RADIUS 2))

(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define TWO-WHEELS (underlay/offset WHEEL (* WHEEL-DIAMETER 2) 0 WHEEL))

(define CAR-BODY (rectangle (* WHEEL-DIAMETER 4) WHEEL-DIAMETER "solid" "blue"))
(define CAR-BODY-TOP (rectangle (* WHEEL-DIAMETER 2) WHEEL-DIAMETER "solid" "blue"))
(define CAR
  (underlay/offset CAR-BODY-TOP
                   0 WHEEL-DIAMETER
                   (underlay/offset CAR-BODY
                                    0 WHEEL-RADIUS
                                    TWO-WHEELS)))
(define CAR-WIDTH (image-width CAR))

(define TREE
  (underlay/offset (circle WHEEL-DIAMETER "solid" "green")
               0 WHEEL-DIAMETER
               (rectangle (/ WHEEL-RADIUS 2) (* WHEEL-RADIUS 3) "solid" "brown")))

(define BACKGROUND-WIDTH (* (image-width CAR) 8))
(define BACKGROUND-HEIGHT (* (image-height CAR) 2))
(define BACKGROUND
  (place-image TREE
               (/ BACKGROUND-WIDTH 3)
               (- BACKGROUND-HEIGHT (/ (image-height TREE) 2))
               (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT)))

(define Y-CAR (- BACKGROUND-HEIGHT (/ (image-height CAR) 2)))
(define X-CAR-STOP (+ BACKGROUND-WIDTH (/ CAR-WIDTH 2)))


;; WorldState -> Image
;; Places the car into the scene.
(define (render ws)
  (place-image CAR ws Y-CAR BACKGROUND))

;; WorldState -> WorldState
;; Sets world state for every clock tick.
(define (tick-handler ws)
  (+ ws VELOCITY))

;; WorldState Number Number String -> WorldState
;; Places the car at x-mouse
;; if the given me is "button-down".
(define (hyper x-car x-mouse y-mouse me)
  (if (string=? "button-down" me) x-mouse x-car))

;; WorldState -> Number
;; Calculates when to stop the car.
(define (end? ws)
  (> ws X-CAR-STOP))

(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick tick-handler]
    [on-mouse hyper]
    [stop-when end?]))


;; Application
(main 0) ; the car is centered at x=0

