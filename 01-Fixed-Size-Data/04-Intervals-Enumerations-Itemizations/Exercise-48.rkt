;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-48) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 48.
;; Enter the definition of reward followed by (reward 18)
;; into the definitions area of DrRacket
;; and use the stepper to find out
;; how DrRacket evaluates applications of the function.

;; A PositiveNumber is a Number greater than/equal to 0.

;; Unit Tests
(check-expect (reward 3) "bronze")
(check-expect (reward 18) "silver")
(check-expect (reward 21) "gold")

;; PositiveNumber -> String
;; Computes the reward level from the given score s.
(define (reward s)
  (cond
    [(<= 0 s 10) "bronze"]
    [(and (< 10 s) (<= s 20)) "silver"]
    [else "gold"]))

;; Application
(reward 18)

