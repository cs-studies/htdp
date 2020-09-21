;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-491) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 491.
;; Does the following solution mean
;; there is no need for our complicated design in this motivational section?


;; [List-of Number] -> [List-of Number]
;; Converts a list of relative to absolute distances.
;; The first number represents the distance to the origin.
(check-expect (relative->absolute '(50 40 70 30 30)) '(50 90 160 190 220))
(define (relative->absolute l)
 (reverse
   (foldr (lambda (f l) (cons (+ f (first l)) l))
          (list (first l))
          (reverse (rest l)))))

;(time (relative->absolute (build-list 10000 add1)))

;;; Answer
;; foldr is just one more example of how accumulators can be used.
;; The foldr's second argument l accumulates processed data,
;; so no knowledge loss happens with this implementation.
;; Also, other programming languages may require more time
;; processing reverse function call,
;; so this function may become a bottleneck of such implementation.


;; [List-of Any] -> [List-of Any]
;; Reverses the items on the given list.
(check-expect (rev '(1 2)) '(2 1))
(define (rev l)
  (cond
    [(empty? l) '()]
    [else (put-last (first l) (rev (rest l)))]))

;; Any [List-of Any] -> [List-of Any]
;; Appends the given item i to the end of the list l.
(check-expect (put-last 1 '(2)) '(2 1))
(define (put-last i l)
  (cond
    [(empty? l) (cons i '())]
    [else (cons (first l) (put-last i (rest l)))]))

;; [List-of Number] -> [List-of Number]
;; Example implementation that calls non-performant function rev.
(check-expect (relative->absolute.v2 '(50 40 70 30 30)) '(50 90 160 190 220))
(define (relative->absolute.v2 l)
 (rev
   (foldr (lambda (f l) (cons (+ f (first l)) l))
          (list (first l))
          (rev (rest l)))))

;(time (relative->absolute.v2 (build-list 2000 add1)))

