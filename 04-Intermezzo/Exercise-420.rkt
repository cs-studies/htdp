;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-420) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 420.


;; N is one of:
;; - 0
;; - (add1 N)


;; N -> [List-of Number]
;; Produces the first n elements of a matematical series.
(define (oscillate n)
  (local ((define (O i)
            (cond
              [(> i n) '()]
              [else
               (cons (expt #i-0.99 i) (O (+ i 1)))])))
    (O 1)))


;;; Application

(oscillate 15)


(define osc (oscillate #i1000.0))

(define sum1 (foldl + 0 osc))

(define sum2 (foldl + 0 (reverse osc)))

(- (* 1e+16 sum1) (* 1e+16 sum2))
;; #i14.0

