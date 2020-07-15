;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-309) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 309.
;; Design the function words-on-line,
;; which determines the number of Strings
;; per item in a list of list of strings.


(require 2htdp/abstraction)


;; [List-of [List-of String]] -> [List-of Number]
;; Determines the number of Strings per item
;; in a list of list of strings.
(check-expect (words-on-line '()) '())
(check-expect (words-on-line '(("cat" "dog") ("am" "fish" "done"))) '(2 3))
(define (words-on-line lls)
  (match lls
    ['() '()]
    [(cons fst rst) (cons (length fst) (words-on-line rst))]))

;; More compact version without matching
(check-expect (words-on-line2 '()) '())
(check-expect (words-on-line2 '(("cat" "dog") ("am" "fish" "done"))) '(2 3))
(define (words-on-line2 lls)
  (for/list ([los lls]) (length los)))

