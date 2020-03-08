;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-20) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 20.
;; Define the function string-delete,
;; which consumes a string plus a number i and deletes the ith position from str.
;; Assume i is a number between 0 (inclusive) and the length of the given string (exclusive).
;; See exercise 4 for ideas. Can string-delete deal with empty strings?

;; Definitions
(define (string-delete str i)
  (if (> (string-length str) 0)
      (string-append (substring str 0 i) (substring str (+ i 1)))
      ""))

;; Application
(string-delete "Funny_Faces" 5)

