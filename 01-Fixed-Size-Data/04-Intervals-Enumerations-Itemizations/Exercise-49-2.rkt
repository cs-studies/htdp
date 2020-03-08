;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-49-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 49.
;; Reformulate create-rocket-scene.v5 to use a nested expression;
;; the resulting function mentions place-image only once.

(require 2htdp/image)

;; Definitions
(define WIDTH  100)
(define HEIGHT  60)
(define MTSCN  (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap "./images/rocket.png"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

;; Number -> Image
(define (create-rocket-scene.v5 h)
  (place-image ROCKET
               50
               (cond
                 [(<= h ROCKET-CENTER-TO-TOP) h]
                 [else ROCKET-CENTER-TO-TOP])
               MTSCN))

