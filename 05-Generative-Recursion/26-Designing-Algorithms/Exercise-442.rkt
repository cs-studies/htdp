;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-442) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 442.
;; Develop create-tests, a function that creates large test cases randomly.
;; Does the experiment confirm the claim that the plain sort< function
;; often wins over quick-sort< for short lists and vice versa?
;; Determine the cross-over point.
;; Use it to build a clever-sort function
;; that behaves like quick-sort< for large lists
;; and like sort< for lists below this cross-over point.
;; Compare with exercise 427.


;; N is one of:
;; - 1
;; - (add1 N)


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of alon.
(check-expect (quick-sort< '()) '())
(check-expect (quick-sort< '(1)) '(1))
(check-expect (quick-sort< (list 11 5 9 2 4)) (list 2 4 5 9 11))
(check-expect (quick-sort< (list 3 2 1 1 2 3)) (list 1 1 2 2 3 3))
(define (quick-sort< alon)
  (cond
    [(or (empty? alon) (empty? (rest alon))) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort<
                     (filter (lambda (x) (< x pivot))
                             (rest alon)))
                    (filter (lambda (x) (= x pivot)) alon)
                    (quick-sort<
                     (filter
                      (lambda (x) (> x pivot))
                      (rest alon)))))]))


;; List-of-numbers -> List-of-numbers
;; Produces a sorted version of the list l.
(check-expect (sort< '()) '())
(check-expect (sort< (list 3 2 1)) (list 1 2 3))
(check-expect (sort< (list 1 2 3)) (list 1 2 3))
(check-expect (sort< (list 12 20 -5)) (list -5 12 20))
(define (sort< l)
  (cond
    [(empty? l) '()]
    [else
     (local ((define (insert n l)
               (cond
                 [(empty? l) (cons n '())]
                 [else (if (<= n (first l))
                           (cons n l)
                           (cons (first l) (insert n (rest l))))])))
       (insert (first l) (sort< (rest l))))]))

;; [[List-of Number] -> [List-of Number]] [List-of N] -> [List-of Number]
;; Runs a function f on a randomly generated lists
;; of the sizes from los and containing numbers from 0 to max.
(define (create-tests f los max)
  (local ((define (run s)
            (time (f (build-list s (lambda (i) (random max)))))))
    (map run los)))


;;; Application

;(define SIZES '(1 10 100 1000 10000))
;(define MAX 10000)

;(create-tests quick-sort< SIZES MAX)
#|
list size -> time
1         -> cpu time: 0 real time: 0 gc time: 0
10        -> cpu time: 0 real time: 0 gc time: 0
100       -> cpu time: 1 real time: 0 gc time: 0
1000      -> cpu time: 8 real time: 7 gc time: 0
10000     -> cpu time: 103 real time: 103 gc time: 30
|#
;(create-tests sort< SIZES MAX)
#|
list size -> time
1         -> cpu time: 1 real time: 1 gc time: 0
10        -> cpu time: 0 real time: 0 gc time: 0
100       -> cpu time: 4 real time: 4 gc time: 0
1000      -> cpu time: 342 real time: 342 gc time: 18
10000     -> cpu time: 36885 real time: 36932 gc time: 1592
|#


(define SIZES '(50 100 500 1000 1500 2000))
(define MAX 1000)

;(create-tests quick-sort< SIZES MAX)
#|
list size -> time
50        -> cpu time: 1 real time: 1 gc time: 0
100       -> cpu time: 1 real time: 1 gc time: 0
500       -> cpu time: 4 real time: 4 gc time: 0
1000      -> cpu time: 28 real time: 28 gc time: 19
1500      -> cpu time: 11 real time: 11 gc time: 0
2000      -> cpu time: 19 real time: 19 gc time: 6
|#
;(create-tests sort< SIZES MAX)
#|
list size -> time
50        -> cpu time: 2 real time: 2 gc time: 0
100       -> cpu time: 4 real time: 4 gc time: 0
500       -> cpu time: 77 real time: 78 gc time: 0
1000      -> cpu time: 324 real time: 325 gc time: 17
1500      -> cpu time: 759 real time: 758 gc time: 24
2000      -> cpu time: 1319 real time: 1312 gc time: 33
|#


;(define SIZES '(1 5 10 15 20 50 60 70 80 90 100))
;(define MAX 1000)

;(create-tests quick-sort< SIZES MAX)
#|
list size -> time
1         -> cpu time: 0 real time: 0 gc time: 0
5         -> cpu time: 1 real time: 1 gc time: 0
10        -> cpu time: 0 real time: 0 gc time: 0
15        -> cpu time: 0 real time: 0 gc time: 0
20        -> cpu time: 0 real time: 0 gc time: 0
50        -> cpu time: 1 real time: 1 gc time: 0
60        -> cpu time: 0 real time: 0 gc time: 0
70        -> cpu time: 0 real time: 1 gc time: 0
80        -> cpu time: 1 real time: 1 gc time: 0
90        -> cpu time: 1 real time: 1 gc time: 0
100       -> cpu time: 1 real time: 1 gc time: 0
|#
;(create-tests sort< SIZES MAX)
#|
list size -> time
1         -> cpu time: 0 real time: 0 gc time: 0
5         -> cpu time: 0 real time: 0 gc time: 0
10        -> cpu time: 0 real time: 0 gc time: 0
15        -> cpu time: 0 real time: 0 gc time: 0
20        -> cpu time: 0 real time: 0 gc time: 0
50        -> cpu time: 1 real time: 1 gc time: 0
60        -> cpu time: 2 real time: 2 gc time: 0
70        -> cpu time: 2 real time: 2 gc time: 0
80        -> cpu time: 3 real time: 3 gc time: 0
90        -> cpu time: 3 real time: 3 gc time: 0
100       -> cpu time: 4 real time: 4 gc time: 0
|#


;;; Answer.
;; The experiment shows quick-sort< performs a bit better
;; than sort< on larger lists, starting the size of 50 items,
;; and significantly better on lists having more than ~500 items.


(define THRESHOLD 49)

;; [List-of Number] -> [List-of Number]
;; Sorts a list l using quick-sort< for large lists
;; and sort< for small lists.
(check-expect (clever-sort '()) '())
(check-expect (clever-sort '(1)) '(1))
(check-expect (clever-sort (list 11 5 9 2 4)) (list 2 4 5 9 11))
(check-expect (clever-sort (list 3 2 1 1 2 3)) (list 1 1 2 2 3 3))
(define (clever-sort alon)
  (cond
    [(or (empty? alon) (empty? (rest alon))) alon]
    [else (local (
                  (define pivot (first alon))

                  (define (threshold-sort< l)
                    (if (<= (length l) THRESHOLD)
                        (sort< l)
                        (clever-sort l))))

            (append
             (threshold-sort< (filter (lambda (x) (< x pivot)) (rest alon)))
             (filter (lambda (x) (= x pivot)) alon)
             (threshold-sort< (filter (lambda (x) (> x pivot)) (rest alon)))))]))


(create-tests clever-sort SIZES MAX)
#|
(define SIZES '(50 100 500 1000 1500 2000))
(define MAX 1000)
cpu time: 2 real time: 2 gc time: 0
cpu time: 1 real time: 2 gc time: 0
cpu time: 7 real time: 7 gc time: 0
cpu time: 12 real time: 13 gc time: 0
cpu time: 46 real time: 46 gc time: 26
cpu time: 24 real time: 24 gc time: 0
|#

