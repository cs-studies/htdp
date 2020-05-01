;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-122) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 122.
;; Suppose the program contains the definition.
;; Show how DrRacket evaluates the following expressions, step-by-step.


(define (f x y)
  (+ (* 3 x) (* y y)))


(+ (f 1 2) (f 2 1))
;; ==
(+
 (+ (* 3 1) (* 2 2))
 (f 2 1))
;; ==
(+
 (+ 3 (* 2 2))
 (f 2 1))
;; ==
(+
 (+ 3 4)
 (f 2 1))
;; ==
(+
 7
 (f 2 1))
;; ==
(+
 7
 (+ (* 3 2) (* 1 1)))
;; ==
(+ 7 (+ 6 (* 1 1)))
;; ==
(+ 7 (+ 6 1))
;; ==
(+ 7 7)
;; ==
;; 14


(f 1 (* 2 3))
;; ==
(f 1 6)
;; ==
(+ (* 3 1) (* 6 6))
;; ==
(+ 3 (* 6 6))
;; ==
(+ 3 36)
;; ==
;; 39


(f (f 1 (* 2 3)) 19)
;; ==
(f (f 1 6) 19)
;; ==
(f
 (+ (* 3 1) (* 6 6))
 19)
;; ==
(f
 (+ 3 (* 6 6))
 19)
;; ==
(f
 (+ 3 36)
 19)
;; ==
(f 39 19)
;; ==
(+ (* 3 39) (* 19 19))
;; ==
(+ 117 (* 19 19))
;; ==
(+ 117 361)
;; ==
;; 478

