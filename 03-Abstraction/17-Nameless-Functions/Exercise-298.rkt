;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-298) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 298.
;; Design my-animate.


(require 2htdp/image)
(require 2htdp/universe)


(define rocket (bitmap "./images/rocket.png"))

;; An ImageStream is a function:
;;   [N -> Image]
;; A stream denotes a series of images.

;; ImageStream
;; Data Example
;; [N -> Image]
;(define (create-rocket-scene height)
;  (place-image ROCKET 70 height (empty-image 60 60)))


;; ImageStream N -> Number
;; Shows the images (s 0), (s 1) and so on
;; at a rate of 30 images per second up to n images total.
(define (my-animate s n0)
  (big-bang 0
    [to-draw s]
    [on-tick add1 1/30]
    [stop-when (lambda (n) (= n n0))]))


;;; Application

;; (my-animate create-rocket-scene 45)
(my-animate
 (lambda (n)
   (place-image rocket 30 n (empty-scene 60 60)))
 45)

