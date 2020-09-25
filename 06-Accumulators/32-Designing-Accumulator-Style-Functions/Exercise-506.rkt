;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-506) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 506.
;; Design an accumulator-style version of map.


;; [X Y] [X -> Y] [List-of X] -> [List-of Y]
;; Constructs a new list by applying function
;; to each item on the list.
(check-expect (map.v1 add1 '()) '())
(check-expect (map.v1 add1 '(1)) '(2))
(check-expect (map.v1 add1 '(1 2)) '(2 3))
(check-expect (map.v1 add1 '(1 2 3)) '(2 3 4))
(check-expect (map.v1 (lambda (x) (* 10 x)) '(1 2 3)) '(10 20 30))
(define (map.v1 f l)
  (cond
    [(empty? l) '()]
    [else (cons (f (first l)) (map.v1 f (rest l)))]))

;(time (map.v1 add1 (build-list 1000 add1)))
;; size  1000  5000  10000  20000
;; time     0     0      0      0


;; [X Y] [X -> Y] [List-of X] -> [List-of Y]
;; Constructs a new list by applying function
;; to each item on the list.
(check-expect (map.v2 add1 '()) '())
(check-expect (map.v2 add1 '(1)) '(2))
(check-expect (map.v2 add1 '(1 2)) '(2 3))
(check-expect (map.v2 add1 '(1 2 3)) '(2 3 4))
(check-expect (map.v2 (lambda (x) (* 10 x)) '(1 2 3)) '(10 20 30))
(define (map.v2 f l0)
  (local (;; [List-of X] [List-of X] -> [List-of X]
          ;; Reverses the list.
          ;; Accumulator a is a list of items on l0
          ;; that are not on l.
          (define (invert/acc l a)
            (cond
              [(empty? l) a]
              [else (invert/acc (rest l) (cons (first l) a))]))

          ;; [List-of X] [List-of Y] -> [List-of Y]
          ;; Constructs a list by applying f to each item on l.
          ;; Accumulator a is a list of items on l0 but not on l,
          ;; processed by function f.
          (define (map/acc l a)
            (cond
              [(empty? l) a]
              [else (map/acc (rest l) (cons (f (first l)) a))])))
    (map/acc (invert/acc l0 '()) '())))

;(time (map.v2 add1 (build-list 1000 add1)))
;; size  1000  5000  10000  20000
;; time     0     0      0      0

