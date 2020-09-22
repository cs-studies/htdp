;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-495) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 495.
;; Complete the manual evaluation of (sum/a '(10 4) 0) in figure 183.


;; [List-of Number] -> Number
;; Calculates the sum of numbers on the given list.
(check-expect (sum.v1 '(10 4)) 14)
(check-expect (sum.v1 '(1 2 3)) 6)
(define (sum.v1 alon)
  (cond
    [(empty? alon) 0]
    [else (+ (first alon) (sum.v1 (rest alon)))]))


;; [List-of Number] -> Number
;; Calculates the sum of numbers on the given list.
(check-expect (sum.v2 '(10 4)) 14)
(check-expect (sum.v2 '(1 2 3)) 6)
(define (sum.v2 alon0)
  (local (;; [List-of Number] Number -> Number
          ;; Computes the sum of the numbers on alon.
          ;; Accumulator a contains the sum of numbers
          ;; that are on alon0 but not on alon.
          (define (sum/a alon a)
            (cond
              [(empty? alon) a]
              [else (sum/a (rest alon)
                           (+ (first alon) a))])))
    (sum/a alon0 0)))

#|
(sum.v2 '(10 4))
;=
(sum/a '(10 4) 0)
;=
(sum/a '(4) (+ 10 0))
;=
(sum/a '() (+ 4 10 0))
;=
(+ 4 10 0)
;=
14
|#

