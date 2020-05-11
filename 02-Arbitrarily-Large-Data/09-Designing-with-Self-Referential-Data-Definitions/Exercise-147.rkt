;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-147) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 147.
;; Develop a data definition for NEList-of-Booleans,
;; a representation of non-empty lists of Boolean values.
;; Then redesign the functions all-true and one-true from exercise 140.


;; An NEList-of-Booleans is one of:
;; - (cons Boolean '())
;; - (cons Boolean NEList-of-Booleans)


;; NEList-of-Booleans -> Boolean
;; Determines whether all booleans in the list are #true.
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
    [(empty? (rest l)) (... (first l) ...)]
    [else
     (... (first l) ...
      ... (all-true (rest l)) ...)]))
|#
(define (all-true l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (and (first l) (all-true (rest l)))]))


;; NEList-of-Booleans -> Boolean
;; Determines whether at least one of the booleans in the list are #true.
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
    [(empty? (rest l)) (... (first l) ...)]
    [else
     (... (first l) ...
      ... (one-true (rest l)) ...)]))
|#
(define (one-true l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (or (first l) (one-true (rest l)))]))

