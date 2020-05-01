;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-125) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 125.
;; Discriminate the legal from the illegal sentences.
;; Explain why the sentences are legal or illegal.


(define-struct oops [])
;; legal
;; matches (define-struct name)

(define-struct child [parents dob date])
;; legal
;; matches (define-struct name [name name name])

(define-struct (child person) [dob date])
;; illegal
;; (child person) part must be a name

