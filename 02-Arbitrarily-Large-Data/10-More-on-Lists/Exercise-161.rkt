;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-161) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 161.
;; Translate the examples into tests and make sure they all succeed.
;; Revise the entire program so that changing the wage for everyone
;; is a single change to the entire program and not several.


;; A List-of-numbers is one of:
;; - '()
;; - (cons Number List-of-numbers)

(define RATE 14)

;; List-of-numbers -> List-of-numbers
;; Computes the weekly wages for all given weekly hours.
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (wage 28) '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (wage 4) (cons (wage 2) '())))
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else (cons (wage (first whrs)) (wage* (rest whrs)))]))

;; Number -> Number
;; Computes the wage for h hours of work.
(check-expect (wage 0) 0)
(check-expect (wage 1) (* RATE 1))
(check-expect (wage 4) (* RATE 4))
(define (wage h)
  (* RATE h))

