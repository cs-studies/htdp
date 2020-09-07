;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-447) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 447.
;; The poly function has two roots.
;; Use find-root with poly and an interval that contains both roots.


(define EPSILON 0.001)

(define ERR-IVT
  "f(new-left) and f(new-right) must be on opposite sides of the x-axis")


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
(check-satisfied (find-root poly 1 6) (lambda (n) (zero? (poly (round n)))))
(check-error (find-root poly 1 8) ERR-IVT)
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
          (find-root f mid right)]
         [else
          (error ERR-IVT)]))]))


;;; Application

(find-root poly 1 6)

(find-root poly -1 8)

(find-root poly 1 8) ; error expected

