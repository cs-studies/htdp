;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-432) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 432.
;; Exercise 219 introduces the function food-create,
;; which consumes a Posn and produces a randomly chosen Posn
;; that is guaranteed to be distinct from the given one.
;; First reformulate the two functions as a single definition, using local;
;; then justify the design of food-create.


(define MAX 10)

#|
;; Posn -> Posn
(check-satisfied (food-create1 (make-posn 1 1)) not=-1-1?)
(define (food-create1 p)
  (food-check-create1
     p (make-posn (random MAX) (random MAX))))

;; Posn Posn -> Posn
;; Generative recursion.
(define (food-check-create1 p candidate)
  (if (equal? p candidate) (food-create1 p) candidate))
|#

;; Posn -> Posn
(check-satisfied (food-create (make-posn 1 1)) not=-1-1?)
(define (food-create p)
  (local ((define candidate (make-posn (random MAX) (random MAX))))
    (if (equal? p candidate) (food-create p) candidate)))


;; Posn -> Boolean
;; Use for testing only.
(define (not=-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))


;;; What is a trivially solvable problem?
;;
;; This algorithm doesn't distinguish between different kinds of problems.
;; It only handles not trivially solvable problems.


;;; How does the algorithm generate new problems
;;; that are more easily solvable than the original one?
;;; Is there one new problem that we generate or are there several?
;;
;; The original problem is attempted to be solved over and over again
;; until a satisfying solution is found.
;; New problems are not generated.
;; The original complexity stays unchanged on each recursive step.

