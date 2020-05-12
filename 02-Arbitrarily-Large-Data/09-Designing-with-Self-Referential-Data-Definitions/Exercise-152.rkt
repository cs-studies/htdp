;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-152) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 152.
;; Design two functions: col and row.


(require 2htdp/image)


;; An N is one of:
;; – 0
;; – (add1 N)
;; Represents the counting numbers.

(define SQUARE (square 10 "outline" "red"))


;; N Image -> Image
;; Produces a column of n copies of img.
(check-expect (col 2 SQUARE) (beside SQUARE SQUARE))
(check-expect (col 0 SQUARE) empty-image)
#|
;; Template
(define (col n img)
  (cond
    [(zero? n) ...]
    [else (... (col (sub1 n) img) ...)]))
|#
(define (col n img)
  (cond
    [(zero? n) empty-image]
    [else (beside img (col (sub1 n) img))]))


;; N Image -> Image
;; Produces a row of n copies of img.
(check-expect (row 2 SQUARE) (above SQUARE SQUARE))
(check-expect (row 0 SQUARE) empty-image)
#|
;; Template
(define (row n img)
  (cond
    [(zero? n) ...]
    [else (... (row (sub1 n) img) ...)]))
|#
(define (row n img)
  (cond
    [(zero? n) empty-image]
    [else (above img (row (sub1 n) img))]))

