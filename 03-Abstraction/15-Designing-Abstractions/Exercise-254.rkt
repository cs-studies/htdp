;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-254) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 254.
;; Formulate signatures for the following functions:
;; - sort-n
;; - sort-s
;; Then abstract over the two signatures.
;; Also show that the generalized signature can be instantiated
;; to describe the signature of a sort function for lists of IRs.


;; sort-n signature
;; [List-of Number] [Number Number -> Boolean] -> [List-of Number]

;; sort-s signature
;; [List-of String] [String String -> Boolean] -> [List-of String]

;; abstract signature
;; [List-of X] [X X -> Boolean] -> [List-of X]

;; sort-IR signature
;; [List-of IR] [IR IR -> Boolean] -> [List-of IR]

