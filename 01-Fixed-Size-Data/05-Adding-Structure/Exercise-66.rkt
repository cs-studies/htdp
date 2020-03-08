;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-66) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 66.
;; Revisit the structure type definitions of exercise 65.
;; Make sensible guesses as to what kind of values go with which fields.
;; Then create at least one instance per structure type definition.


;; Definition 1.
(define-struct movie [title producer year])

;; Constructor
(define m (make-movie "Some Title" "THE Producer" 2020))

;; Selectors
(movie-title m)
(movie-producer m)
(movie-year m)

;; Predicate
(movie? m)


;; Definition 2.
(define-struct person [name hair eyes phone])

;; Constructor
(define p1 (make-person "Alan Turing" "Brown" "Blue" "21-910-532"))

;; Selectors
(person-name p1)
(person-hair p1)
(person-eyes p1)
(person-phone p1)

;; Predicate
(person? p1)
(person? m)


;; Definition 3.
(define-struct pet [name number])

;; Constructor
; make-pet
(define p2 (make-pet "BumbleBee" 33))

;; Selectors
(pet-name p2)
(pet-number p2)

;; Predicate
(pet? p2)
(person? p2)


;; Definition 4.
(define-struct CD [artist title price])

;; Constructor
; make-CD
(define c (make-CD "Maya P." "Dancing" 33.5))

;; Selectors
(CD-artist c)
(CD-title c)
(CD-price c)

;; Predicate
(CD? c)
(CD? m)


;; Definition 5.
(define-struct sweater [material size producer])

;; Constructor
; make-sweater
(define s (make-sweater "Wool" 42 "ZaphodB"))

;; Selectors
(sweater-material s)
(sweater-size s)
(sweater-producer s)

;; Predicate
(sweater? s)
(sweater? c)

