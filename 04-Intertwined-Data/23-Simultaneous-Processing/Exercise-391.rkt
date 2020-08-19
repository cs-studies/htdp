;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-391) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 391.
;; Design replace-eol-with
;; using the strategy of Processing Two Lists Simultaneously: Case 3.
;; Start from the tests. Simplify the result systematically.


;; [List-of Number] [List-of Number] -> [List-of Number]
;; Replaces the final '() in front with end.
(check-expect (replace-eol-with '() '()) '())
(check-expect (replace-eol-with '() '(a b)) '(a b))
(check-expect (replace-eol-with (cons 1 '()) '()) (cons 1 '()))
(check-expect (replace-eol-with (cons 1 '()) '(a)) (cons 1 '(a)))
(check-expect (replace-eol-with (cons 2 (cons 1 '())) '(a))
              (cons 2 (cons 1 '(a))))
(check-expect (replace-eol-with (cons 2 (cons 1 '())) '(a b))
              (cons 2 (cons 1 '(a b))))
#|
(define (replace-eol-with front end)
  (cond
    [(and (empty? front) (empty? end)) ...]
    [(and (empty? front) (cons? end)) ...]
    [(and (cons? front) (empty? end)) ...]
    [(and (cons? front) (cons? end)) ...]))
|#
#|
(define (replace-eol-with front end)
  (cond
    [(and (empty? front) (empty? end)) '()]
    [(and (empty? front) (cons? end)) end]
    [(and (cons? front) (empty? end)) front]
    [(and (cons? front) (cons? end))
     (cons (first front) (replace-eol-with (rest front) end))]))
|#
#|
(define (replace-eol-with front end)
  (cond
    [(and (empty? front) (or (empty? end) (cons? end))) end]
    [(and (cons? front) (empty? end)) front]
    [(and (cons? front) (cons? end))
     (cons (first front) (replace-eol-with (rest front) end))]))
|#
#|
(define (replace-eol-with front end)
  (cond
    [(empty? front) end]
    [(and (cons? front) (empty? end)) front]
    [(and (cons? front) (cons? end))
     (cons (first front) (replace-eol-with (rest front) end))]))
|#
#|
(define (replace-eol-with front end)
  (cond
    [(empty? front) end]
    [(empty? end) front]
    [(cons? end) (cons (first front) (replace-eol-with (rest front) end))]))
|#
(define (replace-eol-with front end)
  (cond
    [(empty? front) end]
;    [(empty? end) front] ; keeping it results in better performance
    [else (cons (first front) (replace-eol-with (rest front) end))]))

