;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-60) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 60.
;; Implement an alternative data representation for a traffic light program
;; that uses numbers instead of strings.
;; Which implementation conveys its intention more clearly?

;; Answer.
;; Numbers representation conveys intention more clearly
;; since the traffic lights are switched in a particular order
;; and this order is easily represented by the Numbers.
;; Also, Numbers help to reduce clutter in this program,
;; even though texts are usually more human-readable.
;; Normally, Strings provide more semantics than Numbers.
;; But in this particular case, Strings just provide
;; presentational data (colors), not the program logic.
;; (Consider the case: the program is going to be used in Japan.
;; Then all the "green" strings would have to be replaced by "blue" strings.
;; That could require a big chunk of time for edits
;; in a large real-world program.)
;; Thus even a better choice would be to use constants
;; to represent possible states of the traffic light.
;; The constants would provide a single point of control over values
;; and be more human-readable then Numbers.

(require 2htdp/universe)
(require 2htdp/image)


;; Data Definitions

;; An TrafficLight is one of the following Numbers:
;; – 0 [red]
;; – 1 [green]
;; – 2 [yellow]
;; Represents the possible states of a traffic light.

;; A BulbColor is one of the following Strings:
;; - "red"
;; - "green"
;; - "yellow"
;; Represents possible colors of traffic light bulbs.

;; An ImageMode is one of the following Strings:
;; - "outline"
;; - "solid"
;; Represents an image outline-mode.


;;; Constants Definitions

(define BULB-RADIUS 30) ; pixels


;; Functions Definitions

;; TrafficLight -> TrafficLight
;; Simulates a clock-based American traffic light.
(define (tl-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]
    ;[state #true]
    ))

;; TrafficLight -> TrafficLight
;; Yields the next state, given current state.
(check-expect (tl-next 0) 1)
(check-expect (tl-next 1) 2)
(check-expect (tl-next 2) 0)
(define (tl-next current-state)
  (modulo (+ current-state 1) 3))

;; TrafficLight -> Image
;; Renders the current state as an image.
(check-expect (tl-render 0)
              (beside (circle BULB-RADIUS "solid" "red")
                      (circle BULB-RADIUS "outline" "yellow")
                      (circle BULB-RADIUS "outline" "green")))
(define (tl-render current-state)
  (beside (draw-bulb 0 current-state)
          (draw-bulb 2 current-state)
          (draw-bulb 1 current-state)))

;; TrafficLigth TrafficLight -> Image
;; Renders a bulb image.
(check-expect (draw-bulb 0 0) (circle BULB-RADIUS "solid" "red"))
(check-expect (draw-bulb 0 1) (circle BULB-RADIUS "outline" "red"))
(define (draw-bulb bulb current-state)
  (circle BULB-RADIUS (image-mode bulb current-state) (as-color bulb)))

;; TrafficLight TrafficLight -> ImageMode
;; Identifies outline-mode of a bulb image.
(check-expect (image-mode 0 0) "solid")
(check-expect (image-mode 0 1) "outline")
(define (image-mode bulb current-state)
  (if (= bulb current-state) "solid" "outline"))

;; TrafficLight -> BulbColor
;; Converts a traffic light state to a color.
(check-expect (as-color 0) "red")
(check-expect (as-color 1) "green")
(check-expect (as-color 2) "yellow")
(check-expect (as-color 100) "red") ; expect to handle an invalid state
(define (as-color state)
  (cond
    [(= 1 state) "green"]
    [(= 2 state) "yellow"]
    [else "red"]))


;; Application
;(tl-simulation 0) ; red color

