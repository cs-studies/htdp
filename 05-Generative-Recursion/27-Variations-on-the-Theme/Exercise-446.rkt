;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-446) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 446.
;; Add the test from exercise 445 to the program in figure 159.
;; Experiment with different values for ε.


(define EPSILON 0.001)


;; Number -> Number
;; Defines a binomial with two roots: 2 and 4.
(check-expect (poly 2) 0)
(check-expect (poly 4) 0)
(define (poly x)
  (* (- x 2) (- x 4)))

;; [Number -> Number] Number Number -> Number
;; Determines R such that f has a root in [R,(+ R EPSILON)].
;; Assume that:
;; - f is continuous
;; - (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left))) (2).
;; Divides interval in half, the root is in
;; one of the two halves, picks according to (2).
(check-within (find-root poly 1 3) 2 0.001)
(check-within (find-root poly 3 5) 4 0.001)
(check-satisfied (find-root poly 3 5) (lambda (n) (zero? (poly (round n)))))
(define (find-root f left right)
  (cond
    [(<= (- right left) EPSILON) left]
    [else
     (local ((define mid (/ (+ left right) 2))
             (define f@m (f mid)))
       (cond
         [(or (<= (f left) 0 f@m) (<= f@m 0 (f left)))
          (find-root f left mid)]
         [(or (<= f@m 0 (f right)) (<= (f right) 0 f@m))
          (find-root f mid right)]))]))

