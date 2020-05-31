;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-181) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 181.
;; Use list to construct the equivalent of the following lists.


(define list-1-1 (cons "a" (cons "b" (cons "c" (cons "d" '())))))
(define list-2-1 (list "a" "b" "c" "d"))
(check-expect list-1-1 list-2-1)

(define list-1-2 (cons (cons 1 (cons 2 '())) '()))
(define list-2-2 (list (list 1 2)))
(check-expect list-1-2 list-2-2)

(define list-1-3 (cons "a" (cons (cons 1 '()) (cons #false '()))))
(define list-2-3 (list "a" (list 1) #false))
(check-expect list-1-3 list-2-3)

(define list-1-4 (cons (cons "a" (cons 2 '())) (cons "hello" '())))
(define list-2-4 (list (list "a" 2) "hello"))
(check-expect list-1-4 list-2-4)

(define list-1-5 (cons (cons 1 (cons 2 '()))
      (cons (cons 2 '())
            '())))
(define list-2-5 (list (list 1 2) (list 2)))
(check-expect list-1-5 list-2-5)

