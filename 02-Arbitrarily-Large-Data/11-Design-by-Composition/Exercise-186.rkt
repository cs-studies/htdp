;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-186) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 186.
;; Use sorted>? from exercise 145 to reformulate the tests for sort> with check-satisfied.
;; Can you formulate a test case that shows
;; that sort>/bad is not a sorting function?
;; Can you use check-satisfied to formulate this test case?


;;; Insertion sort

;; List-of-numbers -> List-of-numbers
;; Produces a sorted version of the list l.
(check-expect (sort> '()) '())
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 12 20 -5)) (list 20 12 -5))
(check-satisfied (sort> (list 3 2 1)) sorted>?)
(check-satisfied (sort> (list 1 2 3)) sorted>?)
(check-satisfied (sort> (list 12 20 -5)) sorted>?)
(define (sort> l)
  (cond
    [(empty? l) '()]
    [else (insert (first l) (sort> (rest l)))]))

;; Number List-of-numbers -> List-of-numbers
;; Inserts n into the sorted list of numbers alon
(check-expect (insert 5 '()) (list 5))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5)) (list 20 12 -5))
(check-expect (insert 1 (list 3 2)) (list 3 2 1))
(check-expect (insert 1 (list 2 3)) (list 2 3 1))
(check-expect (insert 2 (list 1 3)) (list 2 1 3))
(check-expect (insert 2 (list 3 1)) (list 3 2 1))
(define (insert n l)
  (cond
    [(empty? l) (cons n '())]
    [else (if (>= n (first l))
              (cons n l)
              (cons (first l) (insert n (rest l))))]))


;; An NEList-of-numbers is one of:
;; – (cons Number '())
;; – (cons Number NEList-of-temperatures)
;; Represents non-empty lists of numbers.

;; NEList-of-numbers -> NeL
;; Determines if the numbers are sorted in descending order.
(check-expect (sorted>? (cons 1 '())) #true)
(check-expect (sorted>? (cons 2 (cons 1 '()))) #true)
(check-expect (sorted>? (cons 1 (cons 2 '()))) #false)
(define (sorted>? ne-l)
  (cond
    [(empty? (rest ne-l)) #true]
    [else (and
           (> (first ne-l) (first (rest ne-l)))
           (sorted>? (rest ne-l)))]))


;; List-of-numbers -> List-of-numbers
;; Produces a sorted version of l.
(define (sort>/bad l)
  (list 9 8 7 6 5 4 3 2 1 0))

;;; Answer
;;
;; Any check-expect() testing sort>/bad given not sorted list
;; will fail correctly, showing that sort>/bad is not a sorting function.
;; For example: (check-expect (sort>/bad (list 1 2 3)) (list 3 2 1))
;;
;; check-satisfied cannot be used, because sort>/bad always returns
;; a static sorted list. This way, sort>/bad always satisfies sorted>? predicate,
;; returning the sorted (list 9 8 7 6 5 4 3 2 1 0) given any argument.

