;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-459) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 459.
;; Turn the description of the process into an ISL+ function.
;; Adapt the test cases from figure 165 to this case.


(define EPS 0.01)

(define R 159)


;; [Number -> Number] Number Number -> Number
;; Computes the area under the graph of f between a and b.
;; Assumes that (< a b) holds.
(check-within (integrate-rectangles (lambda (x) 20) 12 22) 200 EPS) ; 200
(check-within (integrate-rectangles (lambda (x) (* 2 x)) 0 10) 100 EPS) ; 100
(check-within (integrate-rectangles (lambda (x) (* 3 (sqr x))) 0 10) 1000 EPS) ; 999.9901...
(define (integrate-rectangles f a b)
  (local ((define width (/ (- b a) R))
          (define mid (+ a (/ width 2)))
          (define (integrate-rectangle i)
            (cond
              [(= i R) 0]
              [else (+ (* width (f (+ mid (* i width))))
                       (integrate-rectangle (add1 i)))])))
    (integrate-rectangle 0)))

