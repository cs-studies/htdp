;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-21) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 21.
;; Use DrRacket’s stepper to evaluate (ff (ff 1)) step-by-step.
;; Also try (+ (ff 1) (ff 1)).
;; Does DrRacket’s stepper reuse the results of computations?

;; Definitions
(define (ff a)
  (* 10 a))

;; Application
(ff (ff 1))

(+ (ff 1) (ff 1)) ; the stepper does not reuse the results of computation.

