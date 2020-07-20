;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-67) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 67.
;; Here is another way to represent bouncing balls:
(define SPEED 3)
(define-struct balld [location direction])
(make-balld 10 "up")
;; Interpret this code fragment and create other instances of balld.


;; Answer.
;; 1. Constant SPEED is defined but not used in the given code fragment.
;; 2. Struct balld is defined with two parameters: location and direction.
;; 3. A new istance of the struct balld is created
;;    by calling a constructor make-balld
;;    with parameters 10 (location) and "up" (direction).


;; Instance 1.
(check-expect (balld-location new-balld1) 5)
(define new-balld1 (make-balld 5 "down"))

;; Instance 2.
(check-expect (balld-direction new-balld2) "down")
(define new-balld2 (make-balld 20 "down"))

;; Instance 3.
(check-expect (balld? new-balld3) #true)
(define new-balld3 (make-balld 100 "up"))

