;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-167) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 167.
;; Design the function sum,
;; which consumes a list of Posns
;; and produces the sum of all of its x-coordinates.


;; A List-of-posns is one of:
;; - '()
;; - (cons Posn List-of-posns)

;; List-of-posns -> Number
;; Produces the sum of the x-coordinates of Posns on the list lp.
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 10 30) (cons (make-posn 77 88) '()))) 87)
#|
;; Template
(define (sum lp)
  (cond
    [(empty? lp) ...]
    [(cons? lp) (... (first lp) ...
                     ... ... (posn-x (first lp)) ...
                     ... ... (posn-y (first lp)) ...
                     (sum (rest lp)) ...)]))
|#
(define (sum lp)
  (cond
    [(empty? lp) 0]
    [(cons? lp) (+ (posn-x (first lp)) (sum (rest lp)))]))


;;; Application

;(sum (cons (make-posn 10 30) (cons (make-posn 77 88) '())))

