;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-17) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 17.
;; Define the function image-classify, which consumes an image
;; and conditionally produces "tall" if the image is taller than wide,
;; "wide" if it is wider than tall,
;; or "square" if its width and height are the same.

(require 2htdp/image)

;; Definitions
(define (image-classify img)
  (if (> (image-height img) (image-width img))
      "tall"
      (if (> (image-width img) (image-height img))
          "wide"
          "square")))

