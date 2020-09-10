;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-461) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 461.
;; Design integrate-adaptive.


(define EPS 0.1)


;; [Number -> Number] Number Number -> Number
;; Computes the area under the graph of f between a and b.
;; Assumes that (< a b) holds.
(check-within (integrate-dc (lambda (x) 20) 12 22) 200 EPS) ; 200
(check-within (integrate-dc (lambda (x) (* 2 x)) 0 10) 100 EPS) ; 100
(check-within (integrate-dc (lambda (x) (* 3 (sqr x))) 0 10) 1000 EPS) ; 1000.004884...
(define (integrate-dc f a b)
  (local (
          (define mid (/ (+ a b) 2))

          (define (trapezoid-area l r)
            (* 0.5 (- r l) (+ (f l) (f r))))

          (define trapezoid-l (trapezoid-area a mid))
          (define trapezoid-r (trapezoid-area mid b)))
    (cond
      [(< (abs (- trapezoid-r trapezoid-l)) (* EPS (abs (- b a))))
       (+ trapezoid-l trapezoid-r)]
      [else (+ (integrate-dc f a mid)
               (integrate-dc f mid b))])))


;;; Does integrate-adaptive always compute a better answer
;; than either integrate-kepler or integrate-rectangles?
;; Not always.
;; For example, the answer is the same for a constant and linear functions
;; as shown by the test cases.
;; Also, integrate-rectangles may compute more precise results
;; splitting the area into more rectangles.
;; So, it depends on the exact function and configured approximations.

;;; Which aspect is integrate-adaptive guaranteed to improve?
;; As its name says, the integrate-adaptive adapts
;; to a particular function graph shape,
;; computing the area more precisely and efficiently.

