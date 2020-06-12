;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-209) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 209.
;; Complete the definitions of string->word and word->string.


;; A Word is one of:
;; – '()
;; – (cons 1String Word)
;; Represents a list of 1Strings (letters).


;; String -> Word
;; Converts s to the chosen word representation.
(check-expect (string->word "") '())
(check-expect (string->word "a") (cons "a" '()))
(check-expect (string->word "ab") (list "a" "b"))
(check-expect (string->word "abc") (list "a" "b" "c"))
(define (string->word s)
  (explode s))

;; Word -> String
;; Converts w to a string.
(check-expect (word->string '()) "")
(check-expect (word->string (cons "a" '())) "a")
(check-expect (word->string (list "a" "b")) "ab")
(check-expect (word->string (list "a" "b" "c")) "abc")
(define (word->string w)
  (implode w))

