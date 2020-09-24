;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-505) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 505.
;; Design the function is-prime?,
;; which consumes a natural number
;; and returns #true if it is prime and #false otherwise.


;; N is one of:
;; - 0
;; - (add1 N)

;; N -> Boolean
;; Determines whether n is a prime number.
(check-expect (is-prime? 17) #true)
(check-expect (is-prime? 22) #false)
(define (is-prime? n0)
  (local (;; N -> Boolean
          ;; n is a natural number in the interval [1, n0)
          (define (is-prime n)
            (cond
              [(= n 1) #true]
              [else (and (not (= 0 (modulo n0 n)))
                         (is-prime (sub1 n)))])))
    (is-prime (sub1 n0))))

