;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-504) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 504.
;; Design to10.
;; It consumes a list of digits and produces the corresponding number.
;; The first item on the list is the most significant digit.
;; Hence, when applied to '(1 0 2), it produces 102.


;; N is one of:
;; - 0
;; - (add1 N)

;; [List-of N] -> N
;; Produces a base-10 number.
(check-expect (to10 '()) 0)
(check-expect (to10 '(1)) 1)
(check-expect (to10 '(1 0)) 10)
(check-expect (to10 '(2 5)) 25)
(check-expect (to10 '(1 0 5)) 105)
(define (to10 l0)
  (local (;; [List-of N] N N -> N
          ;; Produces a base-10 number.
          ;; Accumulator a is a base-10 number composed of
          ;; the numbers on l0 which are not on l.
          (define (to10/acc l a)
            (cond
              [(empty? l) a]
              [else (to10/acc (rest l)
                              (+ (first l) (* 10 a)))])))
    (to10/acc l0 0)))


;(time (to10 (build-list 1000 add1)))
;; size 1000  2000  5000  10000  15000
;; time    0     0    18     23     54

