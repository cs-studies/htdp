;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-111) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 111.
;; Develop the function checked-make-vec,
;; which is to be understood as a checked version
;; of the primitive operation make-vec.
;; It ensures that the arguments to make-vec are positive numbers.
;; In other words, checked-make-vec enforces our informal data definition.


(define MESSAGE "make-vec: positive numbers expected")

(define-struct vec [x y])
;; A Vec is
;;  (mave-vec PositiveNumber PositiveNumber)
;; Represents a velocity vector.

;; Any Any -> Vec
;; Checks that x and y are proper input for function make-vec.
(check-expect (checked-make-vec 1 1) (make-vec 1 1))
(check-error (checked-make-vec 0 1) MESSAGE)
(check-error (checked-make-vec 1 0) MESSAGE)
(check-error (checked-make-vec 0 0) MESSAGE)
(check-error (checked-make-vec -1 1) MESSAGE)
(check-error (checked-make-vec 1 -1) MESSAGE)
(check-error (checked-make-vec -1 -1) MESSAGE)
(check-error (checked-make-vec "a" "a") MESSAGE)
(check-error (checked-make-vec "a" 1) MESSAGE)
(check-error (checked-make-vec 1 "a") MESSAGE)
(define (checked-make-vec x y)
  (cond
    [(and (number? x) (> x 0) (number? y) (> y 0))
     (make-vec x y)]
    [else
     (error MESSAGE)]))

