;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-51) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 51.
;; Design a big-bang program
;; that simulates a traffic light for a given duration.
;; The program renders the state of a traffic light
;; as a solid circle of the appropriate color,
;; and it changes state on every clock tick.

(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions
;; State is one of the following Strings:
;; "red", "green", "yellow".
;; Represents the possible states of a traffic light.
;;
;; Duration is a Number.
;; Represents the number of seconds
;; for a traffic light to stay in a set state.
;;
;; LensMode is one of the Strings:
;; "solid", "outline"
;; Represents a mode of a lens image.


;;; Constants Definitions
(define LENS-RADIUS 50)


;;; Functions Definitions

;; State Duration -> Image
;; main function that builds the world.
(define (traffic-light state duration)
  (big-bang state
    [to-draw render]
    [on-tick next-lens duration]))

;; State -> Image
(check-expect (render "red")
              (above (circle LENS-RADIUS "solid" "red")
                     (circle LENS-RADIUS "outline" "yellow")
                     (circle LENS-RADIUS "outline" "green")))
(define (render state)
  (above (draw-lens "red" state)
         (draw-lens "yellow" state)
         (draw-lens "green" state)))

;; State State -> Image
(check-expect (draw-lens "green" "green") (circle LENS-RADIUS "solid" "green"))
(check-expect (draw-lens "green" "yellow") (circle LENS-RADIUS "outline" "green"))
(define (draw-lens lens state)
  (circle LENS-RADIUS (mode lens state) lens))

;; State State -> LensMode
(check-expect (mode "green" "red") "outline")
(check-expect (mode "red" "red") "solid")
(define (mode lens state)
  (if (string=? lens state) "solid" "outline"))

;; State -> State
(check-expect (next-lens "red") "green")
(check-expect (next-lens "green") "yellow")
(check-expect (next-lens "yellow") "red")
(check-expect (next-lens "") "red")
(define (next-lens state)
  (cond
    [(string=? "red" state) "green"]
    [(string=? "green" state) "yellow"]
    [(string=? "yellow" state) "red"]
    [else "red"]))


;; Application
;(traffic-light "red" 2)

