;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-426) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 426.
;; Complete the hand-evaluation.
;; Every time quick-sort< consumes a list of one item, it returns it as is.
;; Modify quick-sort< to take advantage of this observation.
;; How many steps does the revised algorithm save?


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of alon.
;; Assumes the numbers are all distinct.
;(check-expect (quick-sort< (list 11 9 2 18 12 14 4 1)) (list 1 2 4 9 11 12 14 18))
(define (quick-sort< alon)
  (cond
    [(or (empty? alon) (empty? (rest alon))) alon]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers alon pivot))
                    (list pivot)
                    (quick-sort< (largers alon pivot))))]))

;; [List-of Number] Number -> [List-of Number]
;; Produces a list of numbers that are on alon and larger than n.
(define (largers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (largers (rest alon) n))
              (largers (rest alon) n))]))

;; [List-of Number] Number -> [List-of Number]
;; Produces a list of numbers that are on alon and smaller than n.
(define (smallers alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n)
              (cons (first alon) (smallers (rest alon) n))
              (smallers (rest alon) n))]))


;;; Application

(quick-sort< (list 11 8 14 7))
#|
;; ==
(append (quick-sort< (list 8 7))
        (list 11)
        (quick-sort< (list 14)))
;; ==
(append (append (quick-sort< (list 7))
                 (list 8)
                (quick-sort< '()))
        (list 11)
        (quick-sort< (list 14)))
;; ==
(append (append (append (quick-sort< '())
                        (list 7)
                        (quick-sort< '()))
                (list 8)
                (quick-sort< '()))
        (list 11)
        (quick-sort< (list 14)))
;; ==
(append (append (append '()
                         (list 7)
                        '())
                (list 8)
                '())
        (list 11)
        (quick-sort< (list 14)))
;; ==
(append (append (list 7)
                (list 8)
                '())
        (list 11)
        (quick-sort< (list 14)))
;; ==
(append (list 7 8)
        (list 11)
        (quick-sort< (list 14)))
;; ==
(append (list 7 8)
        (list 11)
        (append (quick-sort< '())
                (list 14)
                (quick-sort< '())))
;; ==
(append (list 7 8)
        (list 11)
        (append '()
                (list 14)
                '()))
;; ==
(append (list 7 8)
        (list 11)
        (list 14))
;; ==
(list 7 8 11 14)
|#


;;; Answer
;; The revised algorithm saves 2 steps (1 instead of 3)
;; on each one-element list to be sorted.
;; The stepper showed:
;; - 249 for the initial version of the algorithm
;; - 180 steps for the revised algorithm.

