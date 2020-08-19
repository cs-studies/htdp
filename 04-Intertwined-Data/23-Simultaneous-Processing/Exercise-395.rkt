;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-395) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 395.
;; Design take.
;; It consumes a list l and a natural number n.
;; It produces the first n items from l or all of l if it is too short.
;;
;; Design drop.
;; It consumes a list l and a natural number n.
;; Its result is l with the first n items removed or just ’() if l is too short.


;; N is one of:
;; - 0
;; - (add1 N)


;; [List-of Number] N -> [List-of Number]
;; Produces the first n items from l.
(check-expect (take '() 1) '())
(check-expect (take '(5) 0) '())
(check-expect (take '(5) 1) '(5))
(check-expect (take '(5 10 6 3) 2) '(5 10))
(check-expect (take '(1 2) 10) '(1 2))
(define (take l n)
  (cond
    [(or (empty? l) (= 0 n)) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))

;; [List-of Number] N -> [List-of Number]
;; Removes the first n items from l.
(check-expect (drop '() 1) '())
(check-expect (drop '(5) 0) '(5))
(check-expect (drop '(5) 1) '())
(check-expect (drop '(5) 2) '())
(check-expect (drop '(5 10) 1) '(10))
(check-expect (drop '(5 10 6 3) 0) '(5 10 6 3))
(check-expect (drop '(5 10 6 3) 2) '(6 3))
(check-expect (drop '(5 10 6 3) 20) '())
(define (drop l n)
  (cond
    [(or (empty? l) (= 0 n)) l]
    [else (drop (rest l) (sub1 n))]))

