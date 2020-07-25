;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-350) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 350.
;; What is unusual about the definition of this program
;; with respect to the design recipe?


;;; Answer.
;;
;; 1. parse-sl does not follow a common design recipe for lists.
;; Instead, parse-sl uses more cond branches,
;; handling only particular lists with three elements
;; and returning errors for anything beyond the limits.
;;
;; 2. Atom data type is declared to be accepted by parse function
;; but causes an error if a String or Symbol Atom data is given.
;; This behavior is a sign of the need for data definitions refinements.

