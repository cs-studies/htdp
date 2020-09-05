;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-444) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 444.
;; The very explanation of “greatest common denominator” suggests a two-stage approach.
;; First design a function that can compute
;; the list of divisors of a natural number.
;; Second, design a function that picks the largest common number
;; in the list of divisors of n and the list of divisors of m.


;; N[>= 1] N[>= 1] -> N[>= 1]
;; Finds the greatest common divisor of n1 and n2.
(check-expect (gcd-structural 1 1) 1)
(check-expect (gcd-structural 1 2) 1)
(check-expect (gcd-structural 2 2) 2)
(check-expect (gcd-structural 6 3) 3)
(check-expect (gcd-structural 12 42) 6)
(define (gcd-structural n1 n2)
  (local ((define S (min n1 n2))
          (define L (max n1 n2)))
    (largest-common (divisors S S) (divisors S L))))

;; N[>= 1] N[>= 1] -> [List-of N]
;; Computes the divisors of n smaller or equal to k.
(check-expect (divisors 1 1) '(1))
(check-expect (divisors 1 2) '(1))
(check-expect (divisors 2 1) '(1))
(check-expect (divisors 2 2) '(2 1))
(check-expect (divisors 1 3) '(1))
(check-expect (divisors 2 3) '(1))
(check-expect (divisors 3 3) '(3 1))
(check-expect (divisors 5 3) '(3 1))
(check-expect (divisors 3 6) '(3 2 1))
(check-expect (divisors 6 6) '(6 3 2 1))
(check-expect (divisors 12 6) '(6 3 2 1))
(define (divisors k n)
  (cond
    [(= k 1) '(1)]
    [else (local ((define tail (divisors (sub1 k) n)))
            (if (= (remainder n k) 0) (cons k tail) tail))]))

;; [List-of N] [List-of N] -> N
;; Finds the largest number common to both l1 and l2.
;; Assumes the given lists sorted descendingly.
(check-expect (largest-common '(1) '(1)) 1)
(check-expect (largest-common '(1) '(2 1)) 1)
(check-expect (largest-common '(2 1) '(2 1)) 2)
(check-expect (largest-common '(12 6 4 3 2 1) '(8 4 2 1)) 4)
(check-expect (largest-common '(16 8 4 2 1) '(24 12 8 6 4 3 2 1)) 8)
(define (largest-common l1 l2)
  (cond
    [(empty? l1) '()]
    [else (if (member? (first l1) l2)
              (first l1)
              (largest-common (rest l1) l2))]))


;;; Why do you think divisors consumes two numbers?
;;; Why does it consume S as the first argument in both uses?
;; Only those divisors that are not larger than S (a smaller given number)
;; can potentially be valid common divisors.
;; Computer resources would be wasted looking for any other divisors,
;; even if they would be valid divisors of L (a larger given number).

