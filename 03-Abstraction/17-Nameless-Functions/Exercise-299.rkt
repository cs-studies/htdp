;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-299) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 299.
;; Design a data representation for finite and infinite sets
;; so that you can represent the sets of
;; - all odd numbers,
;; - all even numbers,
;; - all numbers divisible by 10,
;; - and so on.
;; Design the functions
;; - add-element, which adds an element to a set;
;; - union, which combines the elements of two sets;
;; - and intersect, which collects all elements common to two sets.


;; A Set is a function:
;;   [Number -> Boolean]
;; if s is a set and n is a number,
;; (s n) produces #true if n is in s,
;; #false otherwise.


;; Set Number -> Boolean
;; Determines whether a number n is in the set s.
(define (in-set? s n)
  (s n))


;; Number -> Boolean
(lambda (n) (= n 1))

;; Number -> Set
(define (mk-number value)
  (lambda (n) (= n 1)))

(define a-set-of-one (mk-number 1))

(check-expect (in-set? a-set-of-one 1) #true)
(check-expect (in-set? a-set-of-one 10) #false)


;; [Number -> Boolean] -> Set
;; Represents a set of numbers defined by fn.
(check-expect (in-set? (mk-set odd?) 1) #true)
(check-expect (in-set? (mk-set odd?) 2) #false)
(check-expect (in-set? (mk-set even?) 2) #true)
(check-expect (in-set? (mk-set even?) 3) #false)
(check-expect (in-set? (mk-set (lambda (x) (= (modulo x 10) 0))) 100) #true)
(check-expect (in-set? (mk-set (lambda (x) (= (modulo x 10) 0))) 3) #false)
(define (mk-set fn)
  (lambda (n) (fn n)))


;; Set Number -> Boolean
;; Adds elements to a set.
(check-expect (add-element (mk-set odd?) 1) #true)
(check-expect (add-element (mk-set odd?) 2) #false)
(define (add-element s n)
  (in-set? s n))

;; Set Set -> Set
;; Combines the elements of two sets.
(check-expect (in-set? (union (mk-set odd?) (mk-set even?)) 1) #true)
(check-expect (in-set? (union (mk-set odd?) (mk-set even?)) 2) #true)
(check-expect (in-set? (union a-set-of-one (mk-set even?)) 2) #true)
(check-expect (in-set? (union a-set-of-one (mk-set even?)) 1) #true)
(check-expect (in-set? (union a-set-of-one (mk-set even?)) 3) #false)
(define (union s1 s2)
  (lambda (i) (or (in-set? s1 i) (in-set? s2 i))))

;; Set Set -> Set
;; Collects all elements common to two sets.
(check-expect (in-set? (intersect (mk-set odd?) (mk-set even?)) 1) #false)
(check-expect (in-set? (intersect (mk-set odd?) (mk-set even?)) 2) #false)
(check-expect (in-set? (intersect a-set-of-one (mk-set even?)) 2) #false)
(check-expect (in-set? (intersect a-set-of-one (mk-set even?)) 1) #false)
(check-expect (in-set? (intersect a-set-of-one (mk-set odd?)) 1) #true)
(define (intersect s1 s2)
  (lambda (i) (and (in-set? s1 i) (in-set? s2 i))))

