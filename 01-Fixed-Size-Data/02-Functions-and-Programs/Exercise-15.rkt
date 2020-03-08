;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-15) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 15.
;; Define ==>.
;; The function consumes two Boolean values, call them sunny and friday.
;; Its answer is #true if sunny is false or friday is true.

;; Definitions
(define (==> sunny friday)
  (or (not sunny) friday))

