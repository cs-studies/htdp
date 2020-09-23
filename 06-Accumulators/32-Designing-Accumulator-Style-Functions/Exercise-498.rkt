;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-498) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 498.
;; Complete height.v3.


;; N is one of:
;; - 0
;; - (add1 N)

(define-struct node [left right])

;; A Tree is one of:
;; – '()
;; – (make-node Tree Tree)

(define example
  (make-node (make-node '() (make-node '() '())) '()))


;; Tree -> N
;; Computes the height of the binary tree.
(check-expect (height '()) 0)
(check-expect (height (make-node '() '())) 1)
(check-expect (height example) 3)
(define (height bt)
  (cond
    [(empty? bt) 0]
    [else (+ (max (height (node-left bt))
                  (height (node-right bt))) 1)]))

;; Tree -> N
;; Computes the height of the binary tree.
(check-expect (height.v2 '()) 0)
(check-expect (height.v2 (make-node '() '())) 1)
(check-expect (height.v2 example) 3)
(define (height.v2 bt0)
  (local (;; Tree N -> N
          ;; Measures the height of the binary tree.
          ;; Accumulator a is the number of steps
          ;; it takes to reach bt from bt0.
          (define (height/a bt a)
            (cond
              [(empty? bt) a]
              [else
               (max
                (height/a (node-left bt)  (+ a 1))
                (height/a (node-right bt) (+ a 1)))])))
    (height/a bt0 0)))

#|
(height.v2 example)
;=
(height/a (make-node (make-node '() (make-node '() '())) '()) 0)
;=
(max (height/a (make-node '() (make-node '() '())) (+ 0 1))
     (height/a '() (+ 0 1)))
;=
(max (max (height/a '() (+ 1 1))
          (height/a (make-node '() '()) (+ 1 1)))
     (height/a '() 1))
;=
(max (max 2
          (max (height/a '() (+ 2 1))
               (height/a '() (+ 2 1))))
     1)
;=
(max (max 2
          (max 3
               3))
     1)
;=
(max (max 2 3) 1)
;=
3
|#


;; Tree -> [List-of N]
;; Computes the height of the binary tree.
(check-expect (height.v3 '()) 0)
(check-expect (height.v3 (make-node '() '())) 1)
(check-expect (height.v3 example) 3)
(define (height.v3 bt0)
  (local (;; Tree N N -> N
          ;; Measures the height of the binary tree.
          ;; Accumulator s is the number of steps
          ;; it takes to reach bt from bt0
          ;; Accumulator m is the maximal height
          ;; of the part of bt0 that is to the left of bt.
          (define (height/a bt s m)
            (cond
              [(empty? bt) s]
              [else
               (max (height/a (node-left bt) (+ s 1) (+ m 1))
                    (height/a (node-right bt) (+ s 1) m))])))
    (height/a bt0 0 0)))

#|
(height.3 example)
;=
(height/a (make-node (make-node '() (make-node '() '())) '()) 0 0)
;=
(max (height/a (make-node '() (make-node '() '())) (+ 0 1) (+ 0 1))
     (height/a '() (+ 0 1) 0))
;=
(max (max (height/a '() (+ 1 1) (+ 1 1))
          (height/a (make-node '() '()) (+ 1 1) 1))
     (height/a '() 1 0))
;=
(max (max 2
          (max (height/a '() (+ 2 1) (+ 2 1))
               (height/a '() (+ 2 1)) 2))
     1)
;=
(max (max 2
          (max 3
               3))
     1)
;=
(max (max 2 3) 1)
;=
3
|#

