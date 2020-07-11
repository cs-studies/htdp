;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-288) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 288.
;; Use build-list to define a function that
;; - creates the list (list 0 ... (- n 1)) for any natural number n;
;; - creates the list (list 1 ... n) for any natural number n;
;; - creates the list (list 1 1/2 ... 1/n) for any natural number n;
;; - creates the list of the first n even numbers; and
;; - creates a diagonal square of 0s and 1s; see exercise 262.
;; Finally, define tabulate from exercise 250 with lambda.


;; Number -> [List-of Number]
;; Creates the list (list 0 ... (- n 1)).
(check-expect (create-list-0 4) (list 0 1 2 3))
(define (create-list-0 n)
  (build-list n (lambda (i) i)))


;; Number -> [List-of Number]
;; Creates the list (list 1 ... n).
(check-expect (create-list-1 4) (list 1 2 3 4))
(define (create-list-1 n)
  (build-list n add1))


;; Number -> [List-of Number]
;; Creates the list (list 1 1/2 ... 1/n).
(check-expect (create-list-reciprocal 4) (list 1 1/2 1/3 1/4))
(define (create-list-reciprocal n)
  (build-list n (lambda (i) (/ 1 (add1 i)))))


;; Number -> [List-of Number]
;; Creates the list of the first n even numbers.
;; Inline comments show i values.
(check-expect (create-list-even 1) (list 0)) ; 0
(check-expect (create-list-even 2) (list 0 2)) ; 0 1
(check-expect (create-list-even 3) (list 0 2 4)) ; 0 1 2
(check-expect (create-list-even 4) (list 0 2 4 6)) ; 0 1 2 3
(check-expect (create-list-even 5) (list 0 2 4 6 8)) ; 0 1 2 3 4
(define (create-list-even n)
  (build-list n (lambda (i) (* 2 i))))


;; Number -> [List-of [List-of Number]]
;; Creates a diagonal square of 0s and 1s.
(check-expect (create-diagonal-square 1) (list (list 1)))
(check-expect (create-diagonal-square 2) (list (list 1 0) (list 0 1)))
(check-expect (create-diagonal-square 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(define (create-diagonal-square n)
  (build-list n (lambda (i)
                  (build-list n (lambda (j)
                                  (if (= i j) 1 0))))))


;; Number [Number -> Number] -> [List-of Number]
;; Reproduces results of tabulate from Exercise 250.
(check-expect (tabulate 0 sin) (list 0))
(check-expect (tabulate 0 sqrt) (list 0))
(check-within (tabulate 1 sin) (list (sin 1) 0) 0.001)
(check-within (tabulate 2 sqrt) (list (sqrt 2) 1 0) 0.001)
(define (tabulate n f)
  (reverse
     (build-list (add1 n) f)))

