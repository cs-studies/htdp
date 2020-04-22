;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-101) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 101.
;; Turn the examples in figure 35 into test cases.


(require 2htdp/image)


;;; Data Definitions

;; A UFO is a Posn.
;; (make-posn x y) is the UFO's location,
;; using the top-down, left-to-right convention.

(define-struct tank [loc vel])
;; A Tank is a structure:
;;   (make-tank Number Number).
;; (make-tank x dx) specifies the x position
;; and the tank's speed: dx pixels/tick.

;; A MissileOrNot is one of:
;; – #false
;; – Posn
;; #false means the missile is in the tank;
;; Posn says the missile is at that location.

(define-struct gs [ufo tank missile])
;; A GS (short for Game State) is a structure:
;;   (make-gs UFO Tank MissileOrNot)
;; Represents the complete state of a
;; space invader game.


;;; Constants

(define WIDTH 100)
(define HEIGHT 100)
(define BACKGROUND (empty-scene WIDTH HEIGHT "deepskyblue"))

(define UFO-HEIGHT 10)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO-IMAGE (overlay
                   (circle (/ UFO-HEIGHT 2) "solid" "palegreen")
                   (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "green")))

(define TANK-HEIGHT 8)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))
(define TANK-IMAGE (rectangle TANK-WIDTH TANK-HEIGHT "solid" "midnightblue"))

(define MISSILE-IMAGE (triangle 5 "solid" "black"))


;;; Tests Data

(define TEST-UFO (make-posn 20 20))
(define TEST-TANK (make-tank (make-posn 34 TANK-Y) -3))
(define TEST-MISSILE (make-posn 32 (- HEIGHT TANK-HEIGHT 4)))


;;; Functions

;; GS -> Image
;; Renders the given game state on top of BACKGROUND.
(define (si-render gs)
  (tank-render
   (gs-tank gs)
   (ufo-render (gs-ufo gs)
               (missile-render (gs-missile gs)
                               BACKGROUND))))

;; Tank Image -> Image
;; Adds tank to the given image.
(check-expect (tank-render TEST-TANK BACKGROUND)
              (place-image TANK-IMAGE 34 TANK-Y BACKGROUND))
(define (tank-render tank scene)
  (place-image TANK-IMAGE (posn-x (tank-loc tank)) TANK-Y scene))

;; UFO Image -> Image
;; Adds ufo to the given image.
(check-expect (ufo-render TEST-UFO BACKGROUND)
              (place-image UFO-IMAGE 20 20 BACKGROUND))
(define (ufo-render ufo scene)
  (place-image UFO-IMAGE (posn-x ufo) (posn-y ufo) scene))

;; MissileOrNot Image -> Image
;; Adds an image of a missile to the scene.
(check-expect (missile-render #false BACKGROUND) BACKGROUND)
(check-expect (missile-render TEST-MISSILE BACKGROUND)
              (place-image MISSILE-IMAGE (posn-x TEST-MISSILE) (posn-y TEST-MISSILE) BACKGROUND))
(define (missile-render missile scene)
  (if (boolean? missile)
      BACKGROUND
      (place-image MISSILE-IMAGE (posn-x missile) (posn-y missile) scene)))


;;; Application

(define GS-1 (make-gs TEST-UFO TEST-TANK #false))
(si-render GS-1)

(define GS-2 (make-gs TEST-UFO TEST-TANK TEST-MISSILE))
(si-render GS-2)

