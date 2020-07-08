;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-275) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 275.
;; Re-write exercise 198-2 using abstractions.


(require 2htdp/batch-io)


;;; Constants and Data Definitions

;; A Dictionary is a list of *sorted* strings.

(define DICT1 (read-lines "/usr/share/dict/words"))
(define DICT2 (list "abba" "cat" "cheese" "cheetah" "do" "menu" "mi" "mine" "re"))

;; A Letter is one of the following 1Strings:
;; – "a"
;; – ...
;; – "z"
;; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

(define-struct lc [letter count])
;; An LC (short for Letter Count) is a structure:
;;  (make-lc Letter PositiveNumber)


;;; Functions

;; Dictionary -> LC
;; Produces the LC for the letter that occurs most often
;; as the first one in the given Dictionary d.
(check-expect (most-frequent (list "cat")) (make-lc "c" 1))
(check-expect (most-frequent (list "cat" "cheetah")) (make-lc "c" 2))
(check-expect (most-frequent (list "cat" "cheetah" "dog")) (make-lc "c" 2))
(check-expect (most-frequent (list "cat" "cheetah" "dog" "zombi" "zoo")) (make-lc "c" 2))
(define (most-frequent d)
  (local (;; Dictionary -> LC
          (define (dict->lc d)
            (make-lc (first-letter (first d)) (length d))))
    (argmax lc-count (map dict->lc (words-by-first-letter d)))))


;; String -> Letter
;; Produces the first letter of the given word.
(check-expect (first-letter "a") "a")
(check-expect (first-letter "cat") "c")
(define (first-letter word)
  (string-ith word 0))


;; Dictionary -> [List-of Dictionary]
;; Produces a [List-of Dictionary], with one Dictionary per Letter.
(check-expect (words-by-first-letter (list "a")) (list (list "a")))
(check-expect (words-by-first-letter (list "a" "am")) (list (list "a" "am")))
(check-expect (words-by-first-letter (list "a" "Am")) (list (list "a")))
(check-expect (words-by-first-letter (cons "a" (cons "b" '())))
              (cons (cons "a" '()) (cons (cons "b" '()) '())))
(check-expect (words-by-first-letter (list "a" "am" "b"))
              (list (list "a" "am") (list "b")))
(check-expect (words-by-first-letter (list "a" "am" "b" "back"))
              (list (list "a" "am") (list "b" "back")))
(define (words-by-first-letter l)
  (local (;; String -> Boolean
          (define (in-letters? i)
            (member? (first-letter i) LETTERS))
          ;; String [List-of String] -> [List-of Dictionary]
          ;; Foldr provides good performance, iterating over a dictionary only once.
          (define (group x y)
            (cond
              [(empty? y) (list (list x))]
              [else (if
                     (string=? (first-letter x) (first-letter (first (first y))))
                     (cons (cons x (first y)) (rest y))
                     (cons (cons x '()) y))])))
    (foldr group '() (filter in-letters? l))))

;; One more solution with (arguably) better readability but with the degraded performance.
#|
(define (words-by-first-letter l)
  (local ((define (not-empty? item)
            (not (empty? item)))
          (define (traverse i)
            (local ((define (starts-with? word)
                      (string=? (first-letter word) i))
                    (define (group j)
                      j))
              (map group (filter starts-with? l)))))
    (filter not-empty? (map traverse LETTERS))))
|#


;;; Application

;(most-frequent DICT2)
;(most-frequent DICT1)

