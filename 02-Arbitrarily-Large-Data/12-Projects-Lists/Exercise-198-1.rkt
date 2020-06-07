;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-198-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 198.
;; Design words-by-first-letter.
;; The function consumes a Dictionary
;; and produces a list of Dictionaries, one per Letter.


(require 2htdp/batch-io)


;;; Constants and Data Definitions

;; A Letter is one of the following 1Strings:
;; – "a"
;; – ...
;; – "z"
;; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

;; An LoD is a list of Dictionaries, one per Letter.
;; For example,
;; (list
;;   (list "q-word-first" ... "q-word-last")
;;   (list "k-word-first" ... "k-word-last"))

;; An LLC is one of:
;; - '()
;; - (cons LC LLC)

(define ERROR-EMPTY-WORD "first-letter: accepts a non-empty String")


;;; Functions

;; Dictionary -> LoD
;; Produces LoD from a given Dictionary d.
(check-expect (words-by-first-letter '()) '())
(check-expect (words-by-first-letter (list "a")) (list (list "a")))
(check-expect (words-by-first-letter (list "a" "am")) (list (list "a" "am")))
(check-expect (words-by-first-letter (list "a" "b")) (list (list "b") (list "a")))
(check-expect (words-by-first-letter (list "a" "am" "b"))
              (list (list "b") (list "a" "am")))
(check-expect (words-by-first-letter (list "a" "am" "b" "back"))
              (list (list "b" "back") (list "a" "am")))
(define (words-by-first-letter d)
  (cond
    [(empty? d) '()]
    [else (put (first d) (words-by-first-letter (rest d)))]))

;; String LLC -> LLC
;; Adds the word to the given LLC by the word's first letter.
(check-expect (put "a" '()) (list (list "a")))
(check-expect (put "a" (list '())) (list (list "a")))
(check-expect (put "am" (list (list "a"))) (list (list "am" "a")))
(check-expect (put "b" (list (list "a"))) (list (list "a") (list "b")))
(check-expect (put "b" (list (list "a" "am"))) (list (list "a" "am") (list "b")))
(check-expect (put "back" (list (list "a" "am") (list "b")))
              (list (list "a" "am") (list "back" "b")))
(check-expect (put "-" (list (list "a"))) (list (list "a")))
(define (put word llc)
  (if (not (member? (first-letter word) LETTERS))
      llc
      (cond
        [(or (empty? llc) (empty? (first llc))) (list (list word))]
        [else (if (string=? (first-letter word) (first-letter (first (first llc))))
                  (cons (cons word (first llc)) (rest llc))
                  (cons (first llc) (put word (rest llc))))])))

;; String -> Letter
;; Produces the first letter of the given word.
(check-error (first-letter "") ERROR-EMPTY-WORD)
(check-expect (first-letter "a") "a")
(check-expect (first-letter "cat") "c")
(define (first-letter word)
  (cond
    [(string=? "" word) (error ERROR-EMPTY-WORD)]
    [else (string-ith word 0)]))


;;; Application

;(words-by-first-letter (list "cat" "dog" "cheetah" "abba" "menu" "mine" "do" "re" "mi"))

