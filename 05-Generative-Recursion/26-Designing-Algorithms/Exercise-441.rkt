;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-441) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 441.
;; Evaluate by hand.
;; Show only those lines that introduce a new recursive call to quick-sort<.


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



(quick-sort< (list 10 6 8 9 14 12 3 11 14 16 2))
; ==
;(quick-sort< (list 6 8 9 3 2))
; ==
;(quick-sort< (list 3 2))
; ==
;(quick-sort< (list 2))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 8 9))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 9))
; ==
;(quick-sort< (list 14 12 11 14 16))
; ==
;(quick-sort< (list 12 11))
; ==
;(quick-sort< (list 11))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 16))


;;; How many recursive applications of quick-sort< are required?
;; 12

;;; How many recursive applications of the append function?
;; 6

;;; Suggest a general rule for a list of length n.
;; A number of recursions and appends highly depends on
;; the exact contents of a list to sort, so that would be
;; a highly unreliable guess in this context.
;; (Neglecting the fact complexity of this algorithm is very well
;; studied for different scenarios.)


(quick-sort< (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 2 3 4 5 6 7 8 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 3 4 5 6 7 8 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 4 5 6 7 8 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 5 6 7 8 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 6 7 8 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 7 8 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 8 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 9 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 10 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 11 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 12 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 13 14))
; ==
;(quick-sort< '())
; ==
;(quick-sort< (list 14))


;;; How many recursive applications of quick-sort< are required?
;; 26

;;; How many recursive applications of append?
;; 13

;;; Does this contradict the first part of the exercise?
;; The results differ predictably.

