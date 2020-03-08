;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-54) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 54.
;; Why would it be incorrect to use (string=? "resting" x)
;; as the first condition in show?
;; Conversely, formulate a completely accurate condition,
;; that is, a Boolean expression that evaluates to #true
;; precisely when x belongs to the first sub-class of LRCD.


;; Answer.
;; string=? expects String parameters,
;; but x may be a Number in this function.
;; So, it is required to check if x is a String.
;; Without such a check, if x in a Number,
;; the program quits with an error.
;; For example:
;; (define x 4)
;; (string=? "str" x)
;; outputs "string=?: expects a string as 2nd argument, given 4".


;; Accurate Condition.
;; (define x 4) ; #false
;; (define x "rest") ; #false
(define x "resting") ; #true
(and (string? x) (string=? "resting" x))

