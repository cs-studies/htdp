;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-440) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 440.
;; Copy gcd-generative into the definitions area of DrRacket and evaluate
;; (time (gcd-generative 101135853 45014640))
;; in the interactions area.


;; N[>= 1] N[>= 1] -> N
;; Finds the greatest common divisor of n and m.
(check-expect (gcd 6 25) 1)
(check-expect (gcd 18 24) 6)
(define (gcd-generative n m)
  (local (;; N[>= 1] N[>=1] -> N
          ;; Generative recursion.
          ;; (gcd L S) == (gcd S (remainder L S))
          (define (clever-gcd L S)
            (cond
              [(= S 0) L]
              [else (clever-gcd S (remainder L S))])))
    (clever-gcd (max m n) (min m n))))


;;; Application

(time (gcd-generative 101135853 45014640))

