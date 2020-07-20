;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-61) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 61.
;; Use constants for data definitions.

(require 2htdp/universe)
(require 2htdp/image)


;; Constants Definitions

(define RED "red")
(define GREEN "green")
(define YELLOW "yellow")

(define OUTLINE "outline")
(define SOLID "solid")

(define BULB-RADIUS 30) ; pixels


;; Data Definitions

;; A TrafficLight is one of:
;; – RED
;; – GREEN
;; – YELLOW
;; Represents the possible states of a traffic light.

;; An ImageMode is one of:
;; - OUTLINE
;; - SOLID
;; Represents an image outline-mode.


;; Functions Definitions

;; TrafficLight -> TrafficLight
;; Simulates a clock-based American traffic light.
(define (tl-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

;; TrafficLight -> TrafficLight
;; Yields the next state, given current state.
(check-expect (tl-next RED) GREEN)
(check-expect (tl-next GREEN) YELLOW)
(check-expect (tl-next YELLOW) RED)
(define (tl-next current-state)
  (cond
    [(string=? current-state RED) GREEN]
    [(string=? current-state GREEN) YELLOW]
    [(string=? current-state YELLOW) RED]))

;; TrafficLight -> Image
;; Renders the current state as an image.
(check-expect (tl-render RED)
              (beside (circle BULB-RADIUS SOLID RED)
                      (circle BULB-RADIUS OUTLINE YELLOW)
                      (circle BULB-RADIUS OUTLINE GREEN)))
(define (tl-render current-state)
  (beside (draw-bulb RED current-state)
          (draw-bulb YELLOW current-state)
          (draw-bulb GREEN current-state)))

;; TrafficLigth TrafficLight -> Image
;; Renders a bulb image.
(check-expect (draw-bulb RED RED) (circle BULB-RADIUS SOLID RED))
(check-expect (draw-bulb RED GREEN) (circle BULB-RADIUS OUTLINE RED))
(define (draw-bulb bulb current-state)
  (circle BULB-RADIUS (image-mode bulb current-state) (as-color bulb)))

;; TrafficLight TrafficLight -> ImageMode
;; Identifies outline-mode of a bulb image.
(check-expect (image-mode RED RED) SOLID)
(check-expect (image-mode RED GREEN) OUTLINE)
(define (image-mode bulb current-state)
  (if (string=? bulb current-state) SOLID OUTLINE))

;; TrafficLight -> BulbColor
;; Converts a traffic light state to a color.
(check-expect (as-color RED) RED)
(check-expect (as-color GREEN) GREEN)
(check-expect (as-color YELLOW) YELLOW)
(define (as-color state)
  (cond
    [(string=? GREEN state) GREEN]
    [(string=? YELLOW state) YELLOW]
    [else RED]))


;; Application
;(tl-simulation RED)

