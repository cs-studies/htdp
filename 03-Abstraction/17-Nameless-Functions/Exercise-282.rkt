;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-282) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 282.
;; Experiment with the above definitions in DrRacket.


(define (f-plain x)
  (* 10 x))

(define f-lambda
  (lambda (x)
     (* 10 x)))

(check-expect (f-plain 2) (f-lambda 2))

;; Number -> Boolean
(define (compare x)
  (= (f-plain x) (f-lambda x)))

(compare (random 100000))

(compare (random 100000))

(compare (random 100000))

