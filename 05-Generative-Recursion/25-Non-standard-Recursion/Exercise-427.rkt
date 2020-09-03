;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-427) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 427.
;; Develop a version of quick-sort< that uses sort<
;; (an appropriately adapted variant of sort> from
;; Auxiliary Functions that Recur)
;; if the length of the input is below some threshold.


(define THRESHOLD 10)

;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of alon.
;; Assumes the numbers are all distinct.
(check-expect (quick-sort< '()) '())
(check-expect (quick-sort< '(1)) '(1))
(check-expect (quick-sort< (list 11 5 9 2 4)) (list 2 4 5 9 11))
(check-expect (quick-sort< (list 11 9 44 2 18 12 3 14 4 1 10))
              (list 1 2 3 4 9 10 11 12 14 18 44))
(check-expect (quick-sort< (list 11 3 505 44 33 88 303 22 14 55 99 100 202))
              (list 3 11 14 22 33 44 55 88 99 100 202 303 505))
(define (quick-sort< alon)
  (cond
    [(or (empty? alon) (empty? (rest alon))) alon]
    [else (local (
                  (define pivot (first alon))

                  ;; [List-of Number] Number -> [List-of Number]
                  (define (smallers alon n)
                    (filter (lambda (x) (< x n)) alon))

                  ;; [List-of Number] Number -> [List-of Number]
                  (define (largers alon n)
                    (filter (lambda (x) (> x n)) alon))

                  ;; [List-of Number] -> [List-of Number]
                  (define (threshold-sort< l)
                    (if (<= (length l) THRESHOLD)
                        (sort< l)
                        (quick-sort< l))))

            (append (threshold-sort< (smallers alon pivot))
                    (list pivot)
                    (threshold-sort< (largers alon pivot))))]))


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

