;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-140) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 140.
;; Design the function all-true,
;; which consumes a list of Boolean values
;; and determines whether all of them are #true.
;; Now design one-true, a function
;; that consumes a list of Boolean values
;; and determines whether at least one item on the list is #true.


;; A List-of-booleans is one of:
;; - '()
;; - (cons Boolean List-of-Booleans)


;; List-of-Booleans -> Boolean
;; Determines whether all booleans in the list are #true.
(check-expect (all-true '()) #true)
(check-expect (all-true (cons #true '())) #true)
(check-expect (all-true (cons #true (cons #true '()))) #true)
(check-expect (all-true (cons #false '())) #false)
(check-expect (all-true (cons #false (cons #false '()))) #false)
(check-expect (all-true (cons #true (cons #false '()))) #false)
(check-expect (all-true (cons #false (cons #true '()))) #false)
#|
;; Template
(define (all-true l)
  (cond
    [(empty? l) ...]
    [else
     (... (first l) ...
      ... (all-true (rest l)) ...)]))
|#
(define (all-true l)
  (cond
    [(empty? l) #true]
    [else
     (and (first l) (all-true (rest l)))]))


;; List-of-Booleans -> Boolean
;; Determines whether at least one of the booleans in the list are #true.
(check-expect (one-true '()) #false)
(check-expect (one-true (cons #true '())) #true)
(check-expect (one-true (cons #true (cons #true '()))) #true)
(check-expect (one-true (cons #false '())) #false)
(check-expect (one-true (cons #false (cons #false '()))) #false)
(check-expect (one-true (cons #true (cons #false '()))) #true)
(check-expect (one-true (cons #false (cons #true '()))) #true)
#|
;; Template
(define (one-true l)
  (cond
    [(empty? l) ...]
    [else
     (... (first l) ...
      ... (one-true (rest l)) ...)]))
|#
(define (one-true l)
  (cond
    [(empty? l) #false]
    [else
     (or (first l) (one-true (rest l)))]))

