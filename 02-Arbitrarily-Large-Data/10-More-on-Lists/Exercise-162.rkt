;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-162) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 162.
;; To protect the company against fraud, the function should check
;; that no item of the input list of wage* exceeds 100.
;; If one of them does, the function should immediately signal an error.


;; A List-of-numbers is one of:
;; - '()
;; - (cons Number List-of-numbers)

(define RATE 14)
(define MAX-HOURS 100)
(define HOURS-ERROR (string-append "wage*: hours cannot exceed " (number->string MAX-HOURS)))

;; List-of-numbers -> List-of-numbers
;; Computes the weekly wages for all given weekly hours.
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '())) (cons (wage 28) '()))
(check-expect (wage* (cons 4 (cons 2 '()))) (cons (wage 4) (cons (wage 2) '())))
(check-expect (wage* (cons 100 '())) (cons (wage 100) '()))
(check-error (wage* (cons 101 '())) HOURS-ERROR)
(define (wage* whrs)
  (cond
    [(empty? whrs) '()]
    [else
     (if (> (first whrs) MAX-HOURS)
         (error HOURS-ERROR)
         (cons (wage (first whrs)) (wage* (rest whrs))))]))

;; Number -> Number
;; Computes the wage for h hours of work.
(check-expect (wage 0) 0)
(check-expect (wage 1) (* RATE 1))
(check-expect (wage 4) (* RATE 4))
(define (wage h)
  (* RATE h))

