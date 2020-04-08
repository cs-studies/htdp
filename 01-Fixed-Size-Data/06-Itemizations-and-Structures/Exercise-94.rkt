;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-94) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 94.
;; Create your initial scene
;; from the constants for the tank, the UFO, and the background.


(require 2htdp/image)

;;; Constants

(define WIDTH 300)
(define HEIGHT 200)
(define SCENE (empty-scene WIDTH HEIGHT "deepskyblue"))

(define UFO-HEIGHT 20)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO (overlay
             (circle (/ UFO-HEIGHT 2) "solid" "palegreen")
             (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "green")))
(define UFO-X-START (/ WIDTH 2))
(define UFO-Y-START (/ UFO-HEIGHT 2))

(define TANK-HEIGHT 10)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK-X-START (/ TANK-WIDTH 2))
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))
(define TANK (rectangle TANK-WIDTH TANK-HEIGHT "solid" "midnightblue"))


;;; Application

(place-image UFO
             UFO-X-START UFO-Y-START
             (place-image TANK
                          TANK-X-START TANK-Y
                          SCENE))

