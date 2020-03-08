;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-12) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 12.
;; Define the function cvolume, which accepts the length of a side of an equilateral cube
;; and computes its volume. If you have time, consider defining csurface, too.

;; Definitions
(define (cvolume length) (expt length 3))

(define (csurface length) (* (sqr length) 6))

