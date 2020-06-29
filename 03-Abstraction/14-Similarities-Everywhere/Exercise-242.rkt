;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-242) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 242.
;; Interpret the following data definitions.
;; Finish implementing occurs.


;; A [Maybe X] is one of:
;; – #false
;; – X

;; A [Maybe String] is one of:
;; - #false
;; - String

;; A [Maybe [List-of String]] is one of:
;; - #false
;; - [List-of String]

;; A [List-of [Maybe String]] is one of:
;; - '()
;; - (cons [Maybe String] [List-of [Maybe String]])


;; String [List-of String] -> [Maybe [List-of String]]
;; Returns the remainder of los starting with s
;; #false otherwise.
(check-expect (occurs "a" '()) #false)
(check-expect (occurs "a" (list "b" "a" "d" "e")) (list "d" "e"))
(check-expect (occurs "a" (list "b" "c" "d")) #false)
(define (occurs s los)
  (cond
    [(empty? los) #false]
    [(string=? s (first los)) (rest los)]
    [else (occurs s (rest los))]))

