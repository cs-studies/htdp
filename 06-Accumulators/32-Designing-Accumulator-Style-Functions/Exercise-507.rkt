;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-507) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 507.
;; Formulate the signature for fold/a and its accumulator invariant.
;; Design build-l*st using an accumulator-style approach.


;; [X Y] [X Y -> Y] Y [List-of X] -> Y
;; Applies f from left to right to each item on l0 and e.
(check-expect (f*ldl + 0 '(1 2 3)) (foldl + 0 '(1 2 3)))
(check-expect (f*ldl + 5 '(1 2 3)) (foldl + 5 '(1 2 3)))
(check-expect (f*ldl cons '() '(a b c)) (foldl cons '() '(a b c)))
(define (f*ldl f e l0)
  (local (;; Y [List-of X] -> Y
          ;; Applies f to each item on l.
          ;; Accumulator a contains a result of applying f
          ;; to items on l0 that are not on l.
          (define (fold/a a l)
            (cond
              [(empty? l) a]
              [else
               (fold/a (f (first l) a) (rest l))])))
    (fold/a e l0)))

;(time (f*ldl + 1 (build-list 1000 add1)))
;; size  1000  10000  100000
;; time     0      0       9


;; [X Y] [X Y -> Y] Y [List-of X] -> Y
;; Applies f from left to right to each item on l0 and e.
(check-expect (f*ldl.v2 + 0 '(1 2 3)) (foldl + 0 '(1 2 3)))
(check-expect (f*ldl.v2 + 5 '(1 2 3)) (foldl + 5 '(1 2 3)))
(check-expect (f*ldl.v2 cons '() '(a b c)) (foldl cons '() '(a b c)))
(define (f*ldl.v2 f e l)
  (cond
    [(empty? l) e]
    [else (f*ldl.v2 f (f (first l) e) (rest l))]))

;(time (f*ldl.v2 + 1 (build-list 100000 add1)))
;; size  1000  10000  100000
;; time     0      0      21


;; [X] N [N -> X] -> [List-of X]
;; Constructs a list by applying f to 0, 1, ..., (sub1 n).
(check-expect (build-l*st 3 add1) (build-list 3 add1))
(check-expect (build-l*st 3 (lambda (x) (* 10 x))) '(0 10 20))
(define (build-l*st n0 f)
  (local (;; [N or -1] -> [List-of X]
          ;; Constructs a list by applying f to 0, 1, ..., n.
          ;; Accumulator a is a list of processed items.
          (define (build-list/acc n a)
            (cond
              [(negative? n) a]
              [else (build-list/acc (sub1 n) (cons (f n) a))])))
    (build-list/acc (sub1 n0) '())))

;(time (build-l*st 1000 add1))
;; size  1000  10000  100000
;; time     0      0      11

;(time (build-list 1000 add1))
;; size  1000  10000  100000
;; time     0      0      11

