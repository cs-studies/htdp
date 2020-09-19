;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-484) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 484.
;; Hand-evaluate (infL (list 3 2 1 0)).


(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (if (< (first l) (inf (rest l)))
              (first l)
              (inf (rest l)))]))

(inf (list 2 1 0))
;--
;(empty? (list 1 0)) -> #false
;--
;(if (< 2 (inf (list 1 0))) 2 (inf (list 1 0)))
;--
;(empty? (list 0)) -> #false
;--
;(if (< 1 (inf (list 0))) 1 (inf (list 0)))
;--
;(empty? '()) -> #true -> 0
;--
;(if (< 1 0) 1 (inf (list 0)))
;--
;(empty? '()) -> #true -> 0
;--
;(if (< 1 0) 1 0) -> 0
;--
;(if (< 2 0) 2 (inf (list 1 0)))
;--
;(empty? (list 0)) -> #false
;--
;(if (< 1 (inf (list 0))) 1 (inf (list 0)))
;--
;(empty? '()) -> #true -> 0
;--
;(if (< 1 0) 1 (inf (list 0)))
;--
;(empty? '()) -> #true -> 0
;--
;(if (< 2 0) 2 0) -> 0
;--
;0


(define (infL l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (local ((define s (infL (rest l))))
            (if (< (first l) s) (first l) s))]))

(infL (list 3 2 1 0))
;--
;(empty? (list 2 1 0)) -> #false
;--
;(define s_0 (infL (list 2 1 0)))    1st recursive step
;--
;(empty? (list 1 0)) -> #false
;--
;(define s_1 (infL (list 1 0)))      2nd recursive step
;--
;(empty? (list 0)) -> #false
;--
;(define s_2 (infL (list 0)))        3rd recursive step
;--
;(empty? '()) -> #true -> (first l) -> 0
;--
;(define s_2 0)
;--
;(if (< 1 s_2) 1 s_2) -> (if (< 1 0) 1 0) -> 0
;--
;(define s_1 0)
;--
;(if (< 2 s_1) 2 s_1) -> (if (< 2 0) 2 0) -> 0
;--
;(define s_0 0)
;--
;(if (< 3 s_0) 3 s_0) -> (if (< 3 0) 3 0) -> 0
;--
;0


;;; Then argue that infL uses on the "order of n steps"
;;; in the best and the worst case.
;; infL always traverses the given array fully,
;; evaluating one recursive step per array item (except the last one),
;; so the best and the worst case both
;; need on the order of n recursive steps (more precisely, n - 1),
;; on a list of n items.

