;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-422) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 422.
;; Define the function list->chunks.
;; It consumes a list l of arbitrary data and a natural number n.
;; The function’s result is a list of list chunks of size n.
;; Each chunk represents a sub-sequence of items in l.
;; Use list->chunks to define bundle via function composition.


(require racket/list)


;; N is one of:
;; - 0
;; - (add1 N)


;; [X] [List-of X] N -> [List-of [List-of X]]
;; Bundles items on l into a list of sub-sequences of size n.
(check-expect (list->chunks '() 0) '())
(check-expect (list->chunks '() 1) '())
(check-expect (list->chunks '(1) 0) '())
(check-expect (list->chunks '(1) 1) '((1)))
(check-expect (list->chunks '(1) 2) '((1)))
(check-expect (list->chunks '(1 2) 2) '((1 2)))
(check-expect (list->chunks '(1 2 3) 2) '((1 2) (3)))
(check-expect (list->chunks '(10 2 3 5 100 11 4) 3)
              '((10 2 3) (5 100 11) (4)))
(define (list->chunks l n)
  (cond
    [(or (empty? l) (zero? n)) '()]
    [else (if (< (length l) n)
              (cons l '())
              (cons (take l n) (list->chunks (drop l n) n)))]))

;; [List-of 1String] N -> [List-of String]
;; Bundles chunks of s into strings of length n.
(check-expect (bundle '() 0) '())
(check-expect (bundle '("a" "b") 0) '())
(check-expect (bundle '("a" "b" "c") 0) '())
(check-expect (bundle '() 1) '())
(check-expect (bundle '("a" "b") 1) '("a" "b"))
(check-expect (bundle '() 2) '())
(check-expect (bundle '("a" "b") 2) '("ab"))
(check-expect (bundle '("a" "b") 3) '("ab"))
(check-expect (bundle (explode "abcdefg") 3) '("abc" "def" "g"))
(define (bundle s n)
  (map implode (list->chunks s n)))

