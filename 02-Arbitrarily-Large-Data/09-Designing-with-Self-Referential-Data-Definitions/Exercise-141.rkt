;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-141) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 141.
;; Guess a function that can create the desired result
;; from the values computed by the sub-expressions.


;; List-of-string -> String
;; Concatenates all strings in l into one long string.
(check-expect (cat '()) "")
(check-expect (cat (cons "a" (cons "b" '()))) "ab")
(check-expect
  (cat (cons "ab" (cons "cd" (cons "ef" '()))))
  "abcdef")
#|
;; Template
(define (cat l)
  (cond
    [(empty? l) ""]
    [else (... (first l) ... (cat (rest l)) ...)]))
|#
(define (cat l)
  (cond
    [(empty? l) ""]
    [else
     (string-append
      (first l)
      (cat (rest l)))]))


;;; Application

(cat (cons "a" '()))

