;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-211) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 211.
;; Complete the design of in-dictionary.


(require 2htdp/batch-io)


;; On OS X:
(define LOCATION "/usr/share/dict/words")
;; On LINUX: /usr/share/dict/words or /var/lib/dict/words
;; On WINDOWS: borrow the word file from your Linux friend

(define DICTIONARY (read-lines LOCATION))


;; List-of-strings -> List-of-strings
;; Picks out all those Strings that occur in the dictionary.
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "cat")) (list "cat"))
(check-expect (in-dictionary (list "cat" "ttc" "dog")) (list "cat" "dog"))
(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [else (if (member? (first los) DICTIONARY)
               (cons (first los) (in-dictionary (rest los)))
               (in-dictionary (rest los)))]))

