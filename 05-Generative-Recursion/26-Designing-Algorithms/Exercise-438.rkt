;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-438) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 438.
;; In your words: how does greatest-divisor-<= work?
;; Use the design recipe to find the right words.
;; Why does the locally defined greatest-divisor-<= recur on (min n m)?


;; N[>= 1] N[>= 1] -> N
;; Finds the greatest common divisor of n and m.
(check-expect (gcd 6 25) 1)
(check-expect (gcd 18 24) 6)
(define (gcd-structural n m)
  (local (;; N -> N
          ;; Determines the gcd of n and m less than i.
          (define (greatest-divisor-<= i)
            (cond
              [(= i 1) 1]
              [else
               (if (= (remainder n i) (remainder m i) 0)
                   i
                   (greatest-divisor-<= (- i 1)))])))
    (greatest-divisor-<= (min n m))))


;;; Answer.
;; The function tests all natural numbers -
;; starting with the smaller of the given numbers -
;; to 1 (in descending order).
;; It a tested number divides evenly both numbers or equals to 1,
;; this is the gcd.

