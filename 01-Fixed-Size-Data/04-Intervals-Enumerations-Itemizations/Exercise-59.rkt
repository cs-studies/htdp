;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-59) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 59.
;; Finish the design of a world program that simulates the traffic light FSA.

(require 2htdp/universe)
(require 2htdp/image)


;; Data Definitions

;; A TrafficLight is one of the following Strings:
;; – "red"
;; – "green"
;; – "yellow"
;; Represents the possible states of a traffic light.

;; An ImageMode is one of the following Strings:
;; - "outline"
;; - "solid"
;; Represents an image outline-mode.

;;; Constants Definitions

(define BULB-RADIUS 30)


;; Functions Definitions

;; TrafficLight -> TrafficLight
;; Simulates a clock-based American traffic light.
(define (tl-simulation initial-state)
  (big-bang initial-state
    [to-draw tl-render]
    [on-tick tl-next 1]))

;; TrafficLight -> TrafficLight
;; Yields the next state, given current state.
(check-expect (tl-next "red") "green")
(check-expect (tl-next "green") "yellow")
(check-expect (tl-next "yellow") "red")
(define (tl-next current-state)
  (cond
    [(string=? "red" current-state) "green"]
    [(string=? "green" current-state) "yellow"]
    [(string=? "yellow" current-state) "red"]
    [else "red"]))

;; TrafficLight -> Image
;; Renders the current state as an image.
(check-expect (tl-render "red")
              (beside (circle BULB-RADIUS "solid" "red")
                      (circle BULB-RADIUS "outline" "yellow")
                      (circle BULB-RADIUS "outline" "green")))
(define (tl-render current-state)
  (beside (draw-bulb "red" current-state)
          (draw-bulb "yellow" current-state)
          (draw-bulb "green" current-state)))

;; TrafficLigth -> Image
;; Renders a bulb image.
(check-expect (draw-bulb "red" "red") (circle BULB-RADIUS "solid" "red"))
(check-expect (draw-bulb "red" "green") (circle BULB-RADIUS "outline" "red"))
(define (draw-bulb bulb current-state)
  (circle BULB-RADIUS (image-mode bulb current-state) bulb))

;; TrafficLight TrafficLight -> ImageMode
;; Identifies outline-mode of a bulb image.
(check-expect (image-mode "red" "red") "solid")
(check-expect (image-mode "red" "green") "outline")
(define (image-mode bulb current-state)
  (if (string=? bulb current-state) "solid" "outline"))


;; Application
;(tl-simulation "red")

