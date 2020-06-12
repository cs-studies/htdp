;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-213) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;; Exercise 213.
;; Design insert-everywhere/in-all-words.
;; It consumes a 1String and a list of words.
;; The result is a list of words like its second argument,
;; but with the first argument inserted at the beginning,
;; between all letters, and at the end of all words of the given list.


;;; Data Definitions

;; A Word is one of:
;; – '()
;; – (cons 1String Word)
;; Represents a list of 1Strings (letters).

;; A List-of-words is one of:
;; - (cons Word '())
;; - (cons Word List-of-words)


;;; Functions

;; 1String List-of-words -> List-of-words
;; Produces a list of words like the given low
;; but with the given letter inserted
;; at the beginning, between all letters,
;; and at the end of all words of the low.
(check-expect (insert-everywhere/in-all-words "d" (list '())) (list (list "d")))
(check-expect (insert-everywhere/in-all-words "d" (list (list "e")))
              (list (list "d" "e") (list "e" "d")))
(check-expect (insert-everywhere/in-all-words "d" (list (list "e") (list "r")))
              (list (list "d" "e") (list "e" "d") (list "d" "r") (list "r" "d")))
(check-expect (insert-everywhere/in-all-words "d" (list (list "e" "r") (list "r" "e")))
              (list
               (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")
               (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
(define (insert-everywhere/in-all-words letter low)
  (cond
    [(empty? low) '()]
    [else (append (insert-everywhere letter '() (first low))
           (insert-everywhere/in-all-words letter (rest low)))]))

;; 1String Word Word -> List-of-words
;; Produces a list of words by inserting
;; the letter at all the possible positions
;; between the prefix and suffix lists letters.
(check-expect (insert-everywhere "d" '() '()) (list (list "d")))
(check-expect (insert-everywhere "d" '() (list "a"))
              (list (list "d" "a") (list "a" "d")))
(check-expect (insert-everywhere "d" '() (list "a" "e"))
              (list (list "d" "a" "e") (list "a" "d" "e") (list "a" "e" "d")))
(check-expect (insert-everywhere "d" '() (list "a" "e" "r"))
              (list
               (list "d" "a" "e" "r")
               (list "a" "d" "e" "r")
               (list "a" "e" "d" "r")
               (list "a" "e" "r" "d")))
(define (insert-everywhere letter prefix suffix)
  (cond
    [(empty? suffix)
     (list (append prefix (list letter)))]
    [else
     (append
      (list (append prefix (list letter) suffix))
      (insert-everywhere
       letter
       (append prefix (list (first suffix)))
       (rest suffix)))]))


;;; Application

;(insert-everywhere/in-all-words "d" (list (list "e" "r") (list "r" "e")))

