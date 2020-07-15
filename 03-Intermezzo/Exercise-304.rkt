;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-304) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 304.


(require 2htdp/abstraction)


;; [X Y] [List-of X] -> [List-of Y]
;; Produces a list of the same items as on the list l
;; but paired with their relative index.
(check-expect (enumerate '()) '())
(check-expect (enumerate (list 2 4 10))
              '((1 2) (2 4) (3 10)))
(check-expect (enumerate '(a b c)) '((1 a) (2 b) (3 c)))
(define (enumerate l)
  (build-list
   (length l)
   (lambda (i) (list (add1 i) (list-ref l i)))))


(for/list ([i 2] [j '(a b)]) (list i j))

(for*/list ([i 2] [j '(a b)]) (list i j))

