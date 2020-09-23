;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-501) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 501.
;; Design an accumulator-style version of add-to-pi.


;; N is one of:
;; - 0
;; - (add1 N)


;; N -> Number
;; Adds n to pi without using +.
(check-within (add-to-pi 2) (+ 2 pi) 0.001)
(define (add-to-pi n)
  (cond
    [(zero? n) pi]
    [else (add1 (add-to-pi (sub1 n)))]))


;; N -> Number
;; Adds n to pi without using +.
(check-within (add-to-pi.v2 2) (+ 2 pi) 0.001)
(define (add-to-pi.v2 n0)
  (local (;; N Number -> Number
          ;; Adds n to a, which is initially equals to pi.
          ;; Accumulator a is a sum of pi
          ;; and the difference between n0 and n.
          (define (add-to-pi/acc n a)
            (cond
              [(zero? n) a]
              [else (add-to-pi/acc (sub1 n) (add1 a))])))
    (add-to-pi/acc n0 pi)))

