;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-183) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 183.
;; On some occasions lists are formed with cons and list.
;; Reformulate each of the following expressions using only cons or only list.
;; Use check-expect to check your answers.


(define list-1-1 (cons "a" (list 0 #false)))
(define list-2-1 (list "a" 0 #false))
(check-expect list-1-1 list-2-1)

(define list-1-2 (list (cons 1 (cons 13 '()))))
(define list-2-2 (list (list 1 13)))
(check-expect list-1-2 list-2-2)

(define list-1-3 (cons (list 1 (list 13 '())) '()))
(define list-2-3 (list (list 1 (list 13 '()))))
(check-expect list-1-3 list-2-3)

(define list-1-4 (list '() '() (cons 1 '())))
(define list-2-4 (list '() '() (list 1)))
(check-expect list-1-4 list-2-4)

(define list-1-5 (cons "a" (cons (list 1) (list #false '()))))
(define list-2-5 (list "a" (list 1) #false '()))
(check-expect list-1-5 list-2-5)

