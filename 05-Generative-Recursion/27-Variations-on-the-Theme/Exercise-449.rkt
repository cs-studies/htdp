;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-449) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 449.
;; Use local to avoid (f left) and (f right) recomputation.
;; Introduce a helper function that is like find-root
;; but consumes not only left and right
;; but also (f left) and (f right) at each recursive stage.


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
(check-within (find-root-local poly 1 3) 2 0.001)
(check-within (find-root-local poly 3 5) 4 0.001)
(check-satisfied (find-root-local poly 1 6) (lambda (n) (zero? (poly (round n)))))
(check-error (find-root-local poly 1 8) ERR-IVT)
(define (find-root-local f left right)
  (cond
    [(<= (- right left) EPSILON) left]
    [else
     (local ((define mid (/ (+ left right) 2))
             (define f@m (f mid))
             (define f@l (f left))
             (define f@r (f right)))
       (cond
         [(or (<= f@l 0 f@m) (<= f@m 0 f@l))
          (find-root-local f left mid)]
         [(or (<= f@m 0 f@r) (<= f@r 0 f@m))
          (find-root-local f mid right)]
         [else
          (error ERR-IVT)]))]))

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
  (local (
          (define (find-root-acc l r f@l f@r)
            (local (
                    (define mid (/ (+ l r) 2))
                    (define f@m (f mid)))
              (cond
                [(<= (- r l) EPSILON) l]
                [else
                 (cond
                   [(or (<= f@l 0 f@m) (<= f@m 0 f@l))
                    (find-root-acc l mid f@l f@m)]
                   [(or (<= f@m 0 f@r) (<= f@r 0 f@m))
                    (find-root-acc mid r f@m f@r)]
                   [else
                    (error ERR-IVT)])]))))
    (find-root-acc left right (f left) (f right))))


;;; How many recomputations of (f left) does this design maximally avoid?
;; One computation - in comparison with the local computation approach -
;; or two computations - in comparison with the original version of the function -
;; of (f left) on each recursive call of find-root-acc.

