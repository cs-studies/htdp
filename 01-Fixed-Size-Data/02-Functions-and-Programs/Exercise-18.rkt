;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-18) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 18.
;; Define the function string-join, which consumes two strings and appends them with "_" in between.

;; Definitions
(define (string-join str1 str2)
  (string-append str1 "_" str2))

;; Application
(string-join "Funny" "Faces")
  