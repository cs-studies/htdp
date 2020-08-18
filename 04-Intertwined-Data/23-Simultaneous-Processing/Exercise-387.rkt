;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-387) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 387.
;; Design cross.
;; The function consumes a list of symbols and a list of numbers
;; and produces all possible ordered pairs of symbols and numbers.


;; A Pair is a list that contains a Symbol and a Number.

;; [List-of Symbol] [List-of Number] -> [List-of Pair]
;; Produces all possible ordered pairs of symbols and numbers
;; from the given list of symbols and list of numbers.
(check-expect (cross '() '()) '())
(check-expect (cross '(a) '(1))
              (cons (cons 'a (cons 1 '())) '()))
(check-expect (cross '(a) '(1 2))
              (cons (cons 'a (cons 1 '())) (cons (cons 'a (cons 2 '())) '())))
(check-expect (cross '(a b) '(1)) '((a 1) (b 1)))
(check-expect (cross '(a b) '(1 2)) '((a 1) (a 2) (b 1) (b 2)))
(check-expect (cross '(a b c) '(1 2)) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))
(define (cross los lon)
  (cond
    [(empty? los) '()]
    [else (append (cross-one (first los) lon)
                  (cross (rest los) lon))]))

;; Symbol [List-of Number] -> [List-of Pair]
;; Produces pairs of the given symbol and the numbers.
(check-expect (cross-one 'a '()) '())
(check-expect (cross-one 'a '(1)) '((a 1)))
(check-expect (cross-one 'a '(1 2)) '((a 1) (a 2)))
(define (cross-one s lon)
  (cond
    [(empty? lon) '()]
    [else (cons (cons s (cons (first lon) '()))
                (cross-one s (rest lon)))]))


;; [List-of Symbol] [List-of Number] -> [List-of Pair]
(check-expect (cross-abstract '() '()) '())
(check-expect (cross-abstract '(a) '(1)) '((a 1)))
(check-expect (cross-abstract '(a) '(1 2)) '((a 1) (a 2)))
(check-expect (cross-abstract '(a b) '(1)) '((a 1) (b 1)))
(check-expect (cross-abstract '(a b) '(1 2)) '((a 1) (a 2) (b 1) (b 2)))
(check-expect (cross-abstract '(a b c) '(1 2))
              '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))
(define (cross-abstract los lon)
  (foldr (lambda (s l)
           (append (map (lambda (n) (cons s (cons n '()))) lon)
                   l))
         '() los))

