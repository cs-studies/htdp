;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-256) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 256.
;; Explain the following abstract function.
;; Use it on concrete examples in ISL.
;; Can you articulate an analogous purpose statement for argmin?


;; [X] [X -> Number] [NEList-of X] -> X
;; Finds the (first) item in lx that maximizes f
;; if (argmax f (list x-1 ... x-n)) == x-i,
;; then (>= (f x-i) (f x-1)), (>= (f x-i) (f x-2)), ...
;; (define (argmax f lx) ...)


(check-expect (argmax add1 '(2 5 10)) 10)
(check-expect (argmax sub1 '(2 5 10)) 10)
(check-expect (argmax string-length '("abc" "ab" "a")) "abc")


(check-expect (argmin add1 '(2 5 10)) 2)
(check-expect (argmin sub1 '(2 5 10)) 2)
(check-expect (argmin string-length '("abc" "ab" "a")) "a")


;; Answer.
;; argmax returns the (first, if several) member on the given list lx,
;; such that when this member is passed as an argument to the given function f,
;; the function f returns the *largest* value in comparison with the results
;; returned for other members being passed as arguments to f.

;; argmin returns the (first, if several) member on the given list lx,
;; such that when this member is passed as an argument to the given function f,
;; the function f returns the *smallest* value in comparison with the results
;; returned for other members being passed as arguments to f.

