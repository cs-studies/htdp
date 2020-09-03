;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-430) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 430.
;; Develop a variant of quick-sort<
;; that uses only one comparison function, say, <.
;; Its partitioning step divides the given list alon
;; into a list that contains the items of alon smaller than the pivot
;; and another one with those that are not smaller.
;;
;; Use local to package up the program as a single function.
;; Abstract this function so that it consumes a list and a comparison function.


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of alon.
(check-expect (quick-sort '() <) '())
(check-expect (quick-sort '(1) <) '(1))
(check-expect (quick-sort (list 11 5 9 2 4) <) (list 2 4 5 9 11))
(check-expect (quick-sort (list 3 2 1 1 2 3) <) (list 1 1 2 2 3 3))
(check-expect (quick-sort '() >) '())
(check-expect (quick-sort '(1) >) '(1))
(check-expect (quick-sort (list 11 5 9 2 4) >) (list 11 9 5 4 2))
(check-expect (quick-sort (list 3 2 1 1 2 3) >) (list 3 3 2 2 1 1))
(define (quick-sort alon f)
  (cond
    [(or (empty? alon) (empty? (rest alon))) alon]
    [else
     (local ((define pivot (first alon))
             (define equals
               (filter (lambda (x) (= x pivot)) alon))
             (define part1
               (quick-sort (filter (lambda (x) (f x pivot)) alon) f))
             (define part2
               (quick-sort
                (filter (lambda (x)
                          (not (or (member? x equals) (f x pivot))))
                        alon)
                f)))
       (append part1 equals part2))]))

