;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-236) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 236.
;; Create test suites for the following two functions.
;; Then abstract over them.
;; Finally, design a function that subtracts 2 from each number on a given list.


;; Lon -> Lon
;; Adds 1 to each item on l.
(check-expect (add1* '()) '())
(check-expect (add1* '(5)) '(6))
(check-expect (add1* '(5 8 10 42)) '(6 9 11 43))
(define (add1* l)
  (add-each 1 l))

;; Lon -> Lon
;; Adds 5 to each item on l.
(check-expect (plus5 '()) '())
(check-expect (plus5 '(5)) '(10))
(check-expect (plus5 '(5 8 10 42)) '(10 13 15 47))
(define (plus5 l)
  (add-each 5 l))

;; Number Lon -> Lon
;; Adds n to each item on l.
(check-expect (add-each 1 '()) '())
(check-expect (add-each 5 '()) '())
(check-expect (add-each 1 '(5)) '(6))
(check-expect (add-each 5 '(5)) '(10))
(check-expect (add-each 1 '(5 8 10 42)) '(6 9 11 43))
(check-expect (add-each 5 '(5 8 10 42)) '(10 13 15 47))
(define (add-each n l)
  (cond
    [(empty? l) '()]
    [else
     (cons
      (+ (first l) n)
      (add-each n (rest l)))]))

;; Lon -> Lon
;; Subtracts n from each number on l.
(check-expect (sub-each 5 '()) '())
(check-expect (sub-each 5 '(5)) '(0))
(check-expect (sub-each 5 '(5 8 10 42)) '(0 3 5 37))
(define (sub-each n l)
  (cond
    [(empty? l) '()]
    [else
     (cons
      (- (first l) n)
      (sub-each n (rest l)))]))

;; Lon -> Lon
;; Subtracts 2 from each number on l.
(check-expect (sub2 '()) '())
(check-expect (sub2 '(5)) '(3))
(check-expect (sub2 '(5 8 10 42)) '(3 6 8 40))
(define (sub2 l)
  (sub-each 2 l))

