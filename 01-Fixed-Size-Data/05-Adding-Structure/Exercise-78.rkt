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
;; - 1String "a" through "z",
;; - #false.
;; Represents a lowercase letter of a Latin alphabet.
;; #false denotes exceptional cases.

(define-struct word [letter1 letter2 letter3])

;; A Word is a stucture:
;; (make-word Letter Letter Letter).
;; (make-word l1 l2 l3) represents
;; an English language three-letter word
;; that consists of:
;; - the first Letter l1,
;; - the second Letter l2, and
;; - the third [final] Letter l3.

