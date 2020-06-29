;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-239) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 239.
;; Instantiate the given definition to describe the following classes of data.
;; Also make one concrete example for each of these three data definitions.


;; A [List X Y] is a structure:
;;   (cons X (cons Y '()))

;; pairs of Numbers
;; [List Number Number]
(define pair-1 (cons 10 (cons 20 '())))

;; pairs of Numbers and 1Strings
;; [List Number 1String]
(define pair-2 (cons 10 (cons "a" '())))

;; pairs of Strings and Booleans
;; [List String Boolean]
(define pair-3 (cons "hello" (cons #true '())))

