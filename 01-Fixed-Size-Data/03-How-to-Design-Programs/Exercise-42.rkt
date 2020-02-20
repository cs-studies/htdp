;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-42) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 42.
;; Modify the interpretation of the sample data definition so that
;; a state denotes the x-coordinate of the right-most edge of the car.

(require 2htdp/universe)
(require 2htdp/image)

;; Unit tests
(check-expect (render 50) (place-image CAR (car-position 50) Y-CAR BACKGROUND))
(check-expect (render 200) (place-image CAR (car-position 200) Y-CAR BACKGROUND))

(check-expect (tick-handler 20) (+ VELOCITY 20))
(check-expect (tick-handler 78) (+ VELOCITY 78))

(check-expect (end? X-CAR-STOP) #true)
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

(define BACKGROUND-WIDTH (* CAR-WIDTH 8))
(define BACKGROUND-HEIGHT (* (image-height CAR) 2))
(define BACKGROUND
  (place-image TREE
               (/ BACKGROUND-WIDTH 3)
               (- BACKGROUND-HEIGHT (/ (image-height TREE) 2))
               (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT)))

(define Y-CAR (- BACKGROUND-HEIGHT (/ (image-height CAR) 2)))
(define X-CAR-STOP (+ BACKGROUND-WIDTH CAR-WIDTH 1))

;; Number -> Number
;; Converts car x-coordinate
;; from right edge position to center position.
(define (car-position x)
  (- x (/ CAR-WIDTH 2)))

;; A WorldState is a Number.
;; ws (world state) is the number of pixels between
;; the left border of the scene and the right edge of the car.

;; WorldState -> Image
;; Places the car into the scene.
(define (render ws)
  (place-image CAR (car-position ws) Y-CAR BACKGROUND))

;; WorldState -> WorldState
;; Sets world state for every clock tick.
(define (tick-handler ws)
  (+ ws VELOCITY))

;; WorldState -> Number
;; Calculates when to stop the car.
(define (end? ws)
  (>= ws X-CAR-STOP))

(define (main ws)
  (big-bang ws
    [to-draw render]
    [on-tick tick-handler]
    [stop-when end?]))


;; Application
;(main CAR-WIDTH)
(main 0)
