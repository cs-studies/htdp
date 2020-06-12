;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-210) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 210.
;; Complete the design of the words->strings function.


;;; Data Definitions

;; A Word is one of:
;; – '()
;; – (cons 1String Word)
;; Represents a list of 1Strings (letters).

;; A List-of-words is one of:
;; - (cons Word '())
;; - (cons Word List-of-words)


;;; Functions

;; List-of-words -> List-of-strings
;; Converts low to a list of strings.
(check-expect (words->strings (list '())) '())
(check-expect (words->strings (list (list "a"))) (list "a"))
(check-expect (words->strings (list (list "c" "a" "t"))) (list "cat"))
(check-expect (words->strings (list (list "c" "a" "t") (list "d" "o" "g"))) (list "cat" "dog"))
(define (words->strings low)
  (cond
    [(or (empty? low) (empty? (first low))) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))

;; Word -> String
;; Converts w to a string.
(check-expect (word->string '()) "")
(check-expect (word->string (cons "a" '())) "a")
(check-expect (word->string (list "a" "b")) "ab")
(check-expect (word->string (list "a" "b" "c")) "abc")
(define (word->string w)
  (implode w))

