;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-291) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 291.
;; Use fold to define map-via-ford, which simulates map.


;; [X Y] [X -> Y] [List-of X] -> [List-of Y]
(check-expect (map-via-fold add1 '(1 2 3)) '(2 3 4))
(check-expect (map-via-fold sub1 '(1 2 3)) '(0 1 2))
(check-expect (map-via-fold (lambda (i) (list "a" (+ i 1))) '(3 -4 2/5))
              '(("a" 4) ("a" -3) ("a" 1.4)))
(define (map-via-fold f lx)
  (foldr (lambda (x l) (cons (f x) l)) '() lx))

