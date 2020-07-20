;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-160) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 160.
;; Design the functions set+.L and set+.R,
;; which create a set by adding a number x to some given set s
;; for the left-hand and right-hand data definition, respectively.


;; A Set-of-numbers-L is one of:
;; – empty
;; – (cons Number Set-of-numbers-L)
;; May contain not unique numbers.

;; A Set-of-numbers-R is one of:
;; – empty
;; – (cons Number Set-of-numbers-R)
;; Contains only unique numbers.


;; Set-of-numbers-L -> Set-of-numbers-L
;; Adds a number x to the given set s.
(check-expect (set+.L '() 1) (cons 1 '()))
(check-expect (set+.L (cons 1 '()) 1) (cons 1 (cons 1 '())))
(define (set+.L s x)
  (cons x s))

;; Set-of-numbers-R -> Set-of-numbers-R
;; Adds a number x to the given set s.
(check-expect (set+.R '() 1) (cons 1 '()))
(check-expect (set+.R (cons 1 '()) 1) (cons 1 '()))
(define (set+.R s x)
  (if (member? x s)
      s
      (cons x s)))

