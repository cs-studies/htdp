;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-65) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 65.
;; Take a look at the following structure definitions.
;; Write down the names of the functions
;; (constructors, selectors, and predicates) that each introduces.


;; Definition 1.
(define-struct movie [title producer year])

;; Constructor
; make-movie

;; Selectors
; movie-title
; movie-producer
; movie-year

;; Predicate
; movie?


;; Definition 2.
(define-struct person [name hair eyes phone])

;; Constructor
; make-person

;; Selectors
; person-name
; person-hair
; person-eyes
; person-phone

;; Predicate
; person?


;; Definition 3.
(define-struct pet [name number])

;; Constructor
; make-pet

;; Selectors
; pet-name
; pet-number

;; Predicate
; pet?


;; Definition 4.
(define-struct CD [artist title price])

;; Constructor
; make-CD

;; Selectors
; CD-artist
; CD-title
; CD-price

;; Predicate
; CD?


;; Definition 5.
(define-struct sweater [material size producer])

;; Constructor
; make-sweater

;; Selectors
; sweater-material
; sweater-size
; sweater-producer

;; Predicate
; sweater?

