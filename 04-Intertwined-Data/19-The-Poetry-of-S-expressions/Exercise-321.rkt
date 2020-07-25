;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-321) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 321.
;; Abstract the data definitions for S-expr and SL
;; so that they abstract over the kinds of Atoms that may appear.


;; An X is any atomic data type.

;; An SL is a [List-of S-expr]

;; An S-expr is one of:
;; – X
;; – SL

