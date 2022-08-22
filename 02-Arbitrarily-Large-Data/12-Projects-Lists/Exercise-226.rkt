;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-226) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 226.
;; Design state=?, an equality predicate for states.


;; FSM-State is a String that specifies a color.


;; FSM-State FSM-State -> Boolean
;; Verifies equality of two FSM-States.
(check-expect (state=? "red" "green") #false)
(check-expect (state=? "red" "red") #true)
(define (state=? s1 s2)
  (string=? s1 s2))

