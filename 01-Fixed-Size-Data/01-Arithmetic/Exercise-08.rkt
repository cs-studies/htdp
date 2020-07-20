;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-8) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 8.
;; Add the following line to the definitions area:
;; (define cat <image>)
;; Create a conditional expression that computes whether the image is tall or wide.
;; An image should be labeled "tall" if its height is larger than or equal to its width;
;; otherwise it is "wide".
;; Replace the cat with a rectangle of your choice to ensure that you know the expected answer.
;; Now try the following modification.
;; Create an expression that computes whether a picture is "tall", "wide", or "square".

(require 2htdp/image)

;; Definitions
(define cat (bitmap "./images/cat.png")) ; load image to keep this file in a human-readable format 

(define shape (rectangle 40 40 "solid" "white"))
(define shape-width (image-width shape))
(define shape-height (image-height shape))

;; Application
(if (>= (image-height cat) (image-width cat)) "tall" "wide")

(if (> shape-height shape-width)
    "tall"
    (if (< shape-height shape-width) "wide" "square"))

