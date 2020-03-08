;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 5.
;; Use the 2htdp/image library to create the image of a simple boat or tree.
;; Make sure you can easily change the scale of the entire image.

(require 2htdp/image)

;; Definitions
(define WIDTH 250)
(define HEIGHT 250)

(define LEAVES (pulled-regular-polygon (/ HEIGHT 8) 20 1.5 120 "solid" "darkgreen"))
(define TRUNK (isosceles-triangle (/ HEIGHT 2) 12 "solid" "brown"))
(define TREE (overlay/align/offset "center" "bottom" LEAVES 0 (/ HEIGHT 8) TRUNK))
(define BACKGROUND
  (rectangle (+ (image-width TREE) 10) (+ (image-height TREE) 10) "solid" "lightblue"))

;; Application
(overlay/align "center" "bottom" TREE BACKGROUND)

