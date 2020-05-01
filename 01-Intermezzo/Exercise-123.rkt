;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-123) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 123.
;; Write down a rule that shows how to reformulate
;; (if exp-test exp-then exp-else)
;; as a cond expression.


(cond
  [exp-test exp-then]
  [else exp-else])

