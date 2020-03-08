;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname UFO-Landing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Based on https://htdp.org/2019-02-24/part_prologue.html

(require 2htdp/image)
(require 2htdp/universe)

;; Scene size definitions
(define SCENE-WIDTH 200)
(define SCENE-HEIGHT 400)

;; Rock definitions
(define ROCK-HEIGHT 10)
(define ROCK-WIDTH (* 2 ROCK-HEIGHT))
(define ROCK-CENTER-Y (- SCENE-HEIGHT (/ ROCK-HEIGHT 2)))

;; Scene definitions
(define SCENE-CENTER-X (/ SCENE-WIDTH 2))
(define SCENE (place-image
               (rectangle ROCK-WIDTH ROCK-HEIGHT "solid" "brown")
               SCENE-CENTER-X
               ROCK-CENTER-Y
               (empty-scene SCENE-WIDTH SCENE-HEIGHT "blue")))

;; UFO definitions
(define UFO-IMAGE (overlay
                   (circle 1 "solid" "red")
                   (circle 10 "solid" "green")
                   (rectangle 40 4 "solid" "green")
                   ))
(define UFO-LANDED-Y (- SCENE-HEIGHT (/ (image-height UFO-IMAGE) 2) ROCK-HEIGHT))
(define VELOCITY 3) ; pixels per universe clock tick

;; UFO landing definitions
(define (move-ufo-to y) (place-image UFO-IMAGE SCENE-CENTER-X y SCENE))

(define (calculate-y ticks) (* VELOCITY ticks))

(define (ufo ticks)
  (cond
    [(<= (calculate-y ticks) UFO-LANDED-Y) (move-ufo-to (calculate-y ticks))]
    [(> (calculate-y ticks) UFO-LANDED-Y)  (move-ufo-to UFO-LANDED-Y)]))

;; Application
(animate ufo)

