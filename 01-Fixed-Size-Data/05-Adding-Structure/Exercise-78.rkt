;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-78) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 78.
;; Provide a structure type and a data definition
;; for representing three-letter words.
;; A word consists of lowercase letters,
;; represented with the 1Strings "a" through "z" plus #false.


;; A Letter is one of:
;; - 1String [a-z]
;; Represents a lowercase letter of a Latin alphabet.

;; A 3String is a String of length 3,
;; that can be constructed from Letters.
;; Represents a three-letter Latin alphabet string.

(define-struct word [letter1 letter2 letter3])

;; A Word is a stucture
;; (make-word Letter Letter Letter)
;; that produces one of:
;; - 3String
;; - #false.
;; (make-word l1 l2 l3) represents
;; an English language word that consists of:
;; the first letter l1,
;; the second letter l2, and
;; the third [final] letter l3.
;; Produces #false if a word cannot be constructed.

