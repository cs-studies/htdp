;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-39) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 39.
;; Develop your favorite image of an automobile
;; so that WHEEL-RADIUS remains the single point of control.

(require 2htdp/image)

;; Definitions
(define WHEEL-RADIUS 5)
(define WHEEL-DIAMETER (* WHEEL-RADIUS 2))

(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))

(define TWO-WHEELS
  (underlay/offset WHEEL (* WHEEL-DIAMETER 2) 0 WHEEL))

(define CAR-BODY
  (rectangle (* WHEEL-DIAMETER 4) WHEEL-DIAMETER "solid" "blue"))

(define CAR-BODY-TOP
  (rectangle (* WHEEL-DIAMETER 2) WHEEL-DIAMETER "solid" "blue"))

(define CAR
  (underlay/offset CAR-BODY-TOP
                   0 (* WHEEL-RADIUS 2)
                   (underlay/offset CAR-BODY
                                0 WHEEL-RADIUS
                                TWO-WHEELS)))

(define BACKGROUND-WIDTH (* (image-width CAR) 8))
(define BACKGROUND-HEIGHT (* (image-height CAR) 2))

(define BACKGROUND
  (empty-scene BACKGROUND-WIDTH BACKGROUND-HEIGHT))

;; Application
(place-image CAR
             (image-width CAR)
             (- BACKGROUND-HEIGHT (/ (image-height CAR) 2))
             BACKGROUND)

