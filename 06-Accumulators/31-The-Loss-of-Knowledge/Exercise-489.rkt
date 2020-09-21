;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-489) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 489.
;; Reformulate add-to-each using map and lambda.


;; Number [List-of Number] -> [List-of Number]
;; Adds n to each number on l.
(check-expect (add-to-each 30 '(40 20)) '(70 50))
(check-expect (cons 50 (add-to-each 50 '(40 110 140 170)))'(50 90 160 190 220))
(define (add-to-each n l)
  (map (lambda (i) (+ n i)) l))

;; [List-of Number] -> [List-of Number]
;; Converts a list of relative to absolute distances.
;; the first number represents the distance to the origin.
(check-expect (relative->absolute '(30)) '(30))
(check-expect (relative->absolute '(40 30)) '(40 70))
(check-expect (relative->absolute '(50 40 70 30 30)) '(50 90 160 190 220))
(define (relative->absolute l)
  (cond
    [(empty? l) '()]
    [else (local ((define n (first l)))
            (cons n
                  (map (lambda (i) (+ n i))
                       (relative->absolute (rest l)))))]))

