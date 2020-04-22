;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-97) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 97.
;; Design functions tank-render, ufo-render, and missile-render.
;; Compare the given expressions.


(require 2htdp/image)


;;; Data Definitions

;; A UFO is a Posn.
;; (make-posn x y) is the UFO's location,
;; using the top-down, left-to-right convention.

(define-struct tank [loc vel])
;; A Tank is a structure:
;;   (make-tank Number Number).
;; (make-tank x dx) specifies the x position
;; and the tank speed: dx pixels/tick.

;; A Missile is a Posn.
;; (make-posn x y) is the missile's position.

(define-struct aim [ufo tank])
;; An Aim is a structure:
;;     (make-aim UFO Tank)
;; Represents states getting tank in position for a shot.

(define-struct fired [ufo tank missile])
;; A Fired is a structure:
;;    (make-fired UFO Tank Missile)
;; Represents states after the missile is fired.


;;; Constants

(define WIDTH 200)
(define HEIGHT 200)
(define BACKGROUND (empty-scene WIDTH HEIGHT "deepskyblue"))

(define UFO-HEIGHT 20)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO-IMAGE (overlay
                   (circle (/ UFO-HEIGHT 2) "solid" "palegreen")
                   (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "green")))

(define TANK-HEIGHT 10)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))
(define TANK-IMAGE (rectangle TANK-WIDTH TANK-HEIGHT "solid" "midnightblue"))

(define MISSILE-IMAGE (triangle 5 "solid" "black"))


;;; Functions

;; Tank Image -> Image
;; Adds tank to the given image.
(check-expect (tank-render (make-tank 50 3) BACKGROUND)
              (place-image TANK-IMAGE 50 TANK-Y BACKGROUND))
(define (tank-render tank img)
  (place-image TANK-IMAGE (tank-loc tank) TANK-Y img))

;; UFO Image -> Image
;; Adds ufo to the given image.
(check-expect (ufo-render (make-posn 50 50) (empty-scene 100 100 "pink"))
              (place-image UFO-IMAGE 50 50 (empty-scene 100 100 "pink")))
(define (ufo-render ufo img)
  (place-image UFO-IMAGE (posn-x ufo) (posn-y ufo) img))

;; Missile Image -> Image
;; Adds missile to the given image.
(check-expect (missile-render (make-posn 40 20) (empty-scene 100 100 "pink"))
              (place-image MISSILE-IMAGE 40 20 (empty-scene 100 100 "pink")))
(define (missile-render missile img)
  (place-image MISSILE-IMAGE (posn-x missile) (posn-y missile) img))


;;; Application

(define UFO (make-posn 50 190))
(define Tank (make-tank 50 -3))
(define Missile (make-posn 45 40))
(define s (make-fired UFO Tank Missile))

;; Compare expression 1
(tank-render
  (fired-tank s)
  (ufo-render (fired-ufo s)
              (missile-render (fired-missile s)
                              BACKGROUND)))

;; Compare expression 2
(ufo-render
  (fired-ufo s)
  (tank-render (fired-tank s)
               (missile-render (fired-missile s)
                               BACKGROUND)))

;; Answer.
;; The given expressions produce the same result when
;; the images of the UFO and the Tank do not overlap.

