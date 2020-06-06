;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-195) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 195.
;; Design the function starts-with#,
;; which consumes a Letter and Dictionary
;; and then counts how many words in the given Dictionary
;; start with the given Letter.


(require 2htdp/batch-io)


;; On OS X:
(define LOCATION "/usr/share/dict/words")
;; On LINUX: /usr/share/dict/words or /var/lib/dict/words
;; On WINDOWS: borrow the word file from your Linux friend

;; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

;; A Letter is one of the following 1Strings:
;; – "a"
;; – ...
;; – "z"
;; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))


;; Letter Dictionary -> Number
;; Counts the number of words starting with l
;; in the given dictionary d.
(check-expect (starts-with# "a" '()) 0)
(check-expect (starts-with# "a" (list "cat" "dog")) 0)
(check-expect (starts-with# "c" (list "cat" "dog")) 1)
(check-expect (starts-with# "c" (list "cat" "cheetah" "dog")) 2)
(define (starts-with# l d)
  (cond
    [(empty? d) 0]
    [else (+
           (if (string=? l (string-ith (first d) 0)) 1 0)
           (starts-with# l (rest d)))]))


;;; Application

;(starts-with# "e" AS-LIST)

;(starts-with# "z" AS-LIST)

