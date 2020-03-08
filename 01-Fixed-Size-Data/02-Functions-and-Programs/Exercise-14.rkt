;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-14) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 14.
;; Define the function string-last, which extracts the last 1String from a non-empty string.

;; Definitions
(define (string-last str)
  (if (> (string-length str) 0)
      (substring str (- (string-length str) 1))
      ""))

