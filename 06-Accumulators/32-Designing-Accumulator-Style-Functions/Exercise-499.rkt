;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-499) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 499.
;; Design an accumulator-style version of product,
;; the function that computes the product of a list of numbers.
;; The performance of product is O(n) where n is the length of the list.
;; Does the accumulator version improve on this?


;; [NEList-of Number] -> Number
;; Calculates the product of a list of numbers.
(check-expect (product.v1 '(1)) 1)
(check-expect (product.v1 '(2 3)) 6)
(check-expect (product.v1 '(2 10 3)) 60)
(define (product.v1 lon)
  (cond
    [(empty? lon) 1]
    [else (* (first lon) (product.v1 (rest lon)))]))

#|
(product.v1 '(2 10 3))
;=
(* 2 (product.v1 '(10 3)))
;=
(* 2 (* 10 (product.v1 '(3))))
;=
(* 2 (* 10 (* 3 (product.v1 '()))))
;=
(* 2 (* 10 (* 3 (* 1))))
;=
60
|#


;; [NEList-of Number] -> Number
;; Calculates the product of a list of numbers.
(check-expect (product '(1)) 1)
(check-expect (product '(2 3)) 6)
(check-expect (product '(2 10 3)) 60)
(define (product lon0)
   (local (;; [List-of Number] Number -> Number
          ;; Computes the product of the numbers on lon.
          ;; Accumulator a contains the product of numbers
          ;; that are on lon0 but not on lon.
          (define (product/acc lon a)
            (cond
              [(empty? lon) a]
              [else (product/acc (rest lon) (* (first lon) a))])))
    (product/acc lon0 1)))

#|
(product '(2 10 3))
;=
(product/acc '(10 3) (* 2 1))
;=
(product/acc '(3) (* 10 2))
;=
(product/acc '() (* 3 20))
;=
60
|#


;;; Answer
;; The complexity is reduced to O(1).
;; Detailed information:
;; https://docs.racket-lang.org/guide/Lists__Iteration__and_Recursion.html#%28part._tail-recursion%29
;; https://en.wikipedia.org/wiki/Time_complexity#Constant_time
;; https://en.wikipedia.org/wiki/Tail_call

