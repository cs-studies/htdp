;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-185) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 185.
;; Determine the values of the following expressions.


(define expr1
  (first (list 1 2 3)))

(check-expect expr1 1)


(define expr2
  (rest (list 1 2 3)))

(check-expect expr2 (list 2 3))


(define expr3
  (second (list 1 2 3)))

(check-expect expr3 2)

