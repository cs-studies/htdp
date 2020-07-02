;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-257) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 257.
;; Design build-l*st, which works just like build-list.


;; [X] N [N -> X] -> [List-of X]
;; Constructs a list by applying f to 0, 1, ..., (sub1 n)
;; (build-l*st n f) == (list (f 0) ... (f (- n 1)))
(check-expect (build-l*st 0 add1) '())
(check-expect (build-l*st 1 add1) '(1))
(check-expect (build-l*st 2 add1) '(1 2))
(check-expect (build-l*st 3 add1) '(1 2 3))
(define (build-l*st n f)
  (cond
    [(= 0 n) '()]
    [else (add-at-end (f (sub1 n)) (build-l*st (sub1 n) f))]))

;; [X] X [List-of -> X] -> [List-of X]
;; Creates a new list by adding p to the end of l.
(check-expect (add-at-end 10 '()) '(10))
(check-expect (add-at-end 10 '(1)) '(1 10))
(check-expect (add-at-end 1 '(10 5)) '(10 5 1))
(define (add-at-end x l)
  (cond
   [(empty? l) (cons x '())]
   [else (cons (first l) (add-at-end x (rest l)))]))

