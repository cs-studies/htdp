;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-253) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 253.
;; Each of the following signatures describes a class of functions.
;; Describe these collections with at least one example from ISL.


;; [Number -> Boolean]
(check-expect (>0? 0) #false)
(check-expect (>0? -1) #false)
(check-expect (>0? 1) #true)
(define (>0? n)
  (> n 0))

;; [Boolean String -> Boolean]
(check-expect (bool=string? #true "abc") #false)
(check-expect (bool=string? #true "#true") #true)
(check-expect (bool=string? #false "abc") #false)
(check-expect (bool=string? #false "#true") #false)
(check-expect (bool=string? #false "#false") #true)
(define (bool=string? b s)
  (string=? (boolean->string b) s))

;; [Number Number Number -> Number]
(check-expect (sum 0 0 0) 0)
(check-expect (sum 1 2 3) 6)
(check-expect (sum -1 2 -3) -2)
(define (sum n1 n2 n3)
  (+ n1 n2 n3))

;; [Number -> [List-of Number]]
;; Example for PositiveNumber:
(check-expect (countdown 0) '())
(check-expect (countdown 1) '(1))
(check-expect (countdown 2) '(2 1))
(define (countdown n)
  (cond
    [(= 0 n) '()]
    [else (cons n (countdown (sub1 n)))]))

;; [[List-of Number] -> Boolean]
(check-expect (one-member? '()) #false)
(check-expect (one-member? '(1)) #true)
(check-expect (one-member? '(1 2)) #false)
(define (one-member? l)
  (= 1 (length l)))

