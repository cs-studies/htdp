;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-43-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 43.
;; Use the data definition to design a program
;; that moves the car according to a sine wave.
;;
;; An AnimationState is a Number.
;; interpretation the number of clock ticks
;; since the animation started.

(require 2htdp/universe)
(require 2htdp/image)

;; Unit tests
(check-expect (render 50)
              (place-image CAR (x-position 50) (y-position 50) BACKGROUND))
(check-expect (render 200)
              (place-image CAR (x-position 200) (y-position 200) BACKGROUND))

(check-expect (tick-handler 20) 21)
(check-expect (tick-handler 78) 79)

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
(define CAR-HEIGHT (image-height CAR))

(define TREE
  (underlay/offset (circle WHEEL-DIAMETER "solid" "green")
               0 WHEEL-DIAMETER
               (rectangle (/ WHEEL-RADIUS 2) (* WHEEL-RADIUS 3) "solid" "brown")))

(define BACKGROUND-WIDTH (* CAR-WIDTH 8))
(define BACKGROUND-HEIGHT (* CAR-HEIGHT 2))
(define BACKGROUND
  (place-image TREE
               (/ BACKGROUND-WIDTH 3)
               (- BACKGROUND-HEIGHT (/ (image-height TREE) 2))
               (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT)))

(define X-CAR-STOP (+ BACKGROUND-WIDTH CAR-WIDTH))


(define SINE-AMPLITUDE (/ (- BACKGROUND-HEIGHT CAR-HEIGHT) 2))
(define SINE-FREQUENCY 2)

;; Number -> Number
;; Converts ticks to the car x-position.
(define (x-position ticks)
  (- (* VELOCITY ticks) (/ CAR-WIDTH 2)))

;; Number -> Number
;; Converts ticks to the car y-position.
;; x_in_radians = x * Angular_Frequency
;;              = x * (Cycle_Size_in_Radians * Cycles_Quantity / Fit_into_Width)
;;              = x * (2 * Pi * Frequency / Image_Width)
;;              = x * 2 * Pi * Frequency / Image_Width
;; y(x) = Amplitude * sin(x_in_radians) + Vertical_Shift
(define (y-position ticks)
  (+
   (* SINE-AMPLITUDE -1 ; change sign to match orientation of the canvas
      (sin
        (* (x-position ticks) 2 pi (/ SINE-FREQUENCY BACKGROUND-WIDTH))))
   SINE-AMPLITUDE (/ CAR-HEIGHT 2)))

;; WorldState -> Image
;; Places the car into the scene.
(define (render as)
  (place-image CAR (x-position as) (y-position as) BACKGROUND))

;; WorldState -> WorldState
;; Sets world state for every clock tick.
(define (tick-handler as) (+ as 1))

;; WorldState -> Number
;; Calculates when to stop the car.
(define (end? as)
  (> (x-position as) X-CAR-STOP))

(define (main as)
  (big-bang as
    [to-draw render]
    [on-tick tick-handler]
    [stop-when end?]))


;; Application
(main 0)

