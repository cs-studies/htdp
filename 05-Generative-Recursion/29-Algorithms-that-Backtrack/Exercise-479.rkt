;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-479) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 479.
;; Design the threatening? function.
;; It consumes two QPs and determines whether
;; queens placed on the two respective squares
;; would threaten each other.


(define QUEENS 8)

;; N is one of:
;; - 0
;; - (add1 N)

;; A QP is a structure:
;;   (make-posn CI CI)

;; A CI is an N in [0,QUEENS).
;; interpretation (make-posn r c) denotes the square at
;; the r-th row and c-th column.


;; QP QP -> Boolean
;; Determines whether queens threaten each other.
(check-expect (threatening? (make-posn 0 0) (make-posn 1 2)) #false)
(check-expect (threatening? (make-posn 2 3) (make-posn 5 5)) #false)
(check-expect (threatening? (make-posn 2 3) (make-posn 2 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 2 5)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 6 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 1 2)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 0 1)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 3 4)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 5 6)) #true)
(check-expect (threatening? (make-posn 2 4) (make-posn 3 3)) #true)
(check-expect (threatening? (make-posn 2 4) (make-posn 5 1)) #true)
(check-expect (threatening? (make-posn 2 4) (make-posn 0 6)) #true)
(define (threatening? q1 q2)
  (local ((define q1x (posn-x q1))
          (define q1y (posn-y q1))
          (define q2x (posn-x q2))
          (define q2y (posn-y q2)))
    (or (= q1x q2x)
        (= q1y q2y)
        (= (+ q1x q1y) (+ q2x q2y))
        (= (- q1x q1y) (- q2x q2y)))))

