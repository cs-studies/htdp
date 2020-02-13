;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Ex5) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; Definitions
(define WIDTH 250)
(define HEIGHT 250)

(define LEAVES (pulled-regular-polygon (/ HEIGHT 8) 20 1.5 120 "solid" "darkgreen"))
(define TRUNK (isosceles-triangle (/ HEIGHT 2) 12 "solid" "brown"))
(define TREE (overlay/align/offset "center" "bottom" LEAVES 0 (/ HEIGHT 8) TRUNK))
(define BACKGROUND
  (rectangle (+ (image-width TREE) 10) (+ (image-height TREE) 10) "solid" "lightblue"))

; Application
(overlay/align "center" "bottom" TREE BACKGROUND)
