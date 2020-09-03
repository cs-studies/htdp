;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-428) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 428.
;; If the input to quick-sort< contains the same number several times,
;; the algorithm returns a list that is strictly shorter than the input.
;; Why?
;; Fix the problem so that the output is as long as the input.


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of alon.
(check-expect (quick-sort< '()) '())
(check-expect (quick-sort< '(1)) '(1))
(check-expect (quick-sort< (list 11 5 9 2 4)) (list 2 4 5 9 11))
(check-expect (quick-sort< (list 3 2 1 1 2 3)) (list 1 1 2 2 3 3))
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

                  ;; [List-of Number] Number -> [List-of Number]
                  (define (equals alon n)
                    (filter (lambda (x) (= x n)) alon)))

            (append (quick-sort< (smallers alon pivot))
                    (equals alon pivot)
                    (quick-sort< (largers alon pivot))))]))


;;; Answer.
;; Because it was assumed all the given numbers were distinct
;; and both smallers and largers selected only strictly
;; smaller or larger than pivot values. Numbers equal to pivot
;; were lost with such implementation.

