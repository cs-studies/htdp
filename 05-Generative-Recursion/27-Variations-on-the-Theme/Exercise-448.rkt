;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-448) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 448.
;; The find-root algorithm terminates for all (continuous)
;; f, left, and right for which the assumption holds.
;; Formulate a termination argument.


;;; Termination argument.
;; Note that the distance between left and right
;; becomes smaller on each recursive step.
;; Then, after some number of steps,
;; the distance becomes smaller or equal to EPSILON,
;; leading to the termination of the function.

