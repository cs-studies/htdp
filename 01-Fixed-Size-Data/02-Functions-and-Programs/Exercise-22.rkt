;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-22) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 22.
;; Use DrRacket’s stepper on this program fragment:
;; (define (distance-to-origin x y)
;; (+ (sqr x) (sqr y))))
;; (distance-to-origin 3 4)
;; Does the explanation match your intuition?

(define (distance-to-origin x y)
  (sqrt (+ (sqr x) (sqr y))))

(distance-to-origin 3 4)

