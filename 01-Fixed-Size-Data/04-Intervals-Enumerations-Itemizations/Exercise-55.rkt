;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-55) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 55.
;; Define an auxiliary function that draws a rocket
;; and thus shortens function show.

(require 2htdp/image)


;; Constants Definitions

(define WIDTH 100)
(define HEIGHT 200)
(define SCENE (empty-scene WIDTH HEIGHT))

(define ROCKET (bitmap "./images/rocket.png"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))


;; Functions Definitions

(define (show x)
  (cond
    [(string? x)
     (draw-rocket (- HEIGHT ROCKET-CENTER))]
    [(<= -3 x -1)
     (place-image (text (number->string x) 20 "red")
                  10 (* 3/4 WIDTH)
                  (draw-rocket (- HEIGHT ROCKET-CENTER)))]
    [(>= x 0)
     (draw-rocket (- x ROCKET-CENTER))]))

(define (draw-rocket y)
  (place-image ROCKET 10 y SCENE))

