;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-72) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 72.


;; Task 1.
;; Formulate a data definition
;; for the above phone structure type definition
;; that accommodates the given examples.

(define-struct phone [area number])
;; A Phone is a structure:
;;   (make-phone Number String)
;; Interpretation:
;; area is an area code,
;; number is a local phone number.


;; Task 2.
;; Formulate a data definition for phone numbers
;; using the following structure type definition.
;; Describe the content of the three fields
;; as precisely as possible with intervals.

(define-struct phone# [area switch num])
;; A Phone# is a structure:
;;   (make-phone# Number Number Number)
;; Interpretation:
;; area is an area code [000, 999],
;; switch is a switch code [000, 999],
;; num is a local number [0000, 9999].

