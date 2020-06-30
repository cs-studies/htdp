;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-251) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 251.
;; Design fold1, which is the abstraction of the two functions in figure 93.


;; [List-of Number] Function Number -> Number
;; Computes g of the numbers on l,
;; using on-empty value.
(check-expect (fold1 '() + 0) 0)
(check-expect (fold1 '(1) + 0) 1)
(check-expect (fold1 '(1 2) + 0) 3)
(check-expect (fold1 '() * 1) 1)
(check-expect (fold1 '(1) * 1) 1)
(check-expect (fold1 '(1 2) * 1) 2)
(define (fold1 l g on-empty)
  (cond
    [(empty? l) on-empty]
    [else
     (g (first l)
        (fold1 (rest l) g on-empty))]))

