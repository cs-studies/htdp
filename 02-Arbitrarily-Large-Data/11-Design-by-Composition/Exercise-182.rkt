;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-182) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 182.
;; Use cons and '() to form the equivalent of the following lists.


(define list-1-1 (list 0 1 2 3 4 5))
(define list-2-1 (cons 0 (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))))
(check-expect list-1-1 list-2-1)

(define list-1-2 (list (list "he" 0) (list "it" 1) (list "lui" 14)))
(define list-2-2 (cons
                  (cons "he" (cons 0 '()))
                  (cons
                   (cons "it" (cons 1 '()))
                   (cons (cons "lui" (cons 14 '())) '()))))
(check-expect list-1-2 list-2-2)

(define list-1-3 (list 1 (list 1 2) (list 1 2 3)))
(define list-2-3 (cons 1 (cons
                          (cons 1 (cons 2 '()))
                          (cons (cons 1 (cons 2 (cons 3 '()))) '()))))
(check-expect list-1-3 list-2-3)

