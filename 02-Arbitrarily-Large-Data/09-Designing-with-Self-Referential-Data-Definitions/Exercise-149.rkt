;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-149) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 149.
;; Does copier function properly when you apply it
;; to a natural number and a Boolean or an image?
;; Or do you have to design another function?


(require 2htdp/image)


;; An N is one of:
;; – 0
;; – (add1 N)
;; Represents the counting numbers.

;; A List-of-strings is one of:
;; - '()
;; - (cons String List-of-strings)


;; N String -> List-of-strings
;; Creates a list of n copies of s
(check-expect (copier 0 "hello") '())
(check-expect (copier 2 "hello")
              (cons "hello" (cons "hello" '())))
(define (copier n s)
  (cond
    [(zero? n) '()]
    [(positive? n) (cons s (copier (sub1 n) s))]))


;;; Examples with other data types

(copier 3 100)

(copier 2 #false)

(copier 2 (square 10 "solid" "red"))

(copier 3 0.1)

(copier 1 "x")


;;; Answer
;; Yes, the copier works properly
;; given other data types as the second argument.
;; But the function signature has to be changed to reflect it.
;; An example on how to design a proper data definition
;; to support additional data types in the list
;; is given in the chapter 14.3 Similarities in Data Definitions.

