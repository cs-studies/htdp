;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-24) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 24.
;; Here is the definition of ==>
;; (define (==> x y)
;;   (or (not x) y))
;; Use the stepper to determine the value of (==> #true #false).

(define (==> x y)
  (or (not x) y))

(==> #true #false)

