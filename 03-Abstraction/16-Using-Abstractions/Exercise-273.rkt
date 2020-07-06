;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-273) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 273.
;; Use fold to define map.


;; [X Y] [X -> Y] [List-of X] -> [List-of Y]
(check-expect (map-from-fold add1 '(1 2 3)) '(2 3 4))
(check-expect (map-from-fold sub1 '(1 2 3)) '(0 1 2))
(check-expect (map-from-fold tag-with-a '(3 -4 2/5)) '(("a" 4) ("a" -3) ("a" 1.4)))
(define (map-from-fold f lx)
  (local ((define (traverse x y)
            (cons (f x) y)))
    (foldr traverse '() lx)))

(define (tag-with-a x)
  (list "a" (+ x 1)))

