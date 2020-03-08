;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-53) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 53.
;; Draw some world scenarios and represent them with data and,
;; conversely, pick some data examples and draw pictures that match them.
;; Do so for the LR definition, including at least HEIGHT and 0 as examples.

(require 2htdp/image)

;; Data Definitions

;; An LR (short for launching rocket) is one of:
;; – "resting"
;;   - Represents a grounded rocket.
;; – NonnegativeNumber
;;   - Represents the height of a rocket in flight.
;;   - Height is the distance between the top of the canvas and the center of the rocket. 


;; Constants definitions

(define WIDTH 100)
(define HEIGHT 100)
(define SCENE (empty-scene WIDTH HEIGHT))

(define ROCKET (bitmap "./images/rocket.png"))
(define ROCKET-HEIGHT (image-height ROCKET))


;; Place a rocket into a "resting" position.
(place-image ROCKET (/ WIDTH 2) (- HEIGHT (/ ROCKET-HEIGHT 2)) SCENE)


;; Place a rocket at the center of the scene.
(place-image ROCKET (/ WIDTH 2) (/ HEIGHT 2) SCENE)


;; Place a rocket at the topmost position of the scene.
(place-image ROCKET (/ WIDTH 2) 0 SCENE)


;; Use HEIGHT to position the rocket.
(place-image ROCKET (/ WIDTH 2) HEIGHT SCENE)

