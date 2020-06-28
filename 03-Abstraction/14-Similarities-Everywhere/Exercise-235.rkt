;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-235) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 235.
;; Use the contains? function to define functions
;; that search for "atom", "basic", and "zoo", respectively.


;; String Los -> Boolean
;; Determines whether l contains the string s.
(define (contains? s l)
  (cond
    [(empty? l) #false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))

;; Los -> Boolean
(check-expect (contains-atom? '()) #false)
(check-expect (contains-atom? '("dog" "cat")) #false)
(check-expect (contains-atom? '("dog" "cat" "atom")) #true)
(define (contains-atom? l)
  (contains? "atom" l))

;; Los -> Boolean
(check-expect (contains-basic? '()) #false)
(check-expect (contains-basic? '("dog" "cat")) #false)
(check-expect (contains-basic? '("dog" "basic" "cat")) #true)
(define (contains-basic? l)
  (contains? "basic" l))

;; Los -> Boolean
(check-expect (contains-zoo? '()) #false)
(check-expect (contains-zoo? '("dog" "cat")) #false)
(check-expect (contains-zoo? '("zoo" "cat" "dog")) #true)
(define (contains-zoo? l)
  (contains? "zoo" l))

