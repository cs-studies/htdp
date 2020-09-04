;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-435) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 435.
;; Modify the definition of quick-sort<
;; so that both functions receive lists
;; that are shorter than the given one.


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of alon.
;; Assumes the numbers are all distinct.
(check-expect (quick-sort< '(1)) '(1))
(check-expect (quick-sort< (list 3 1 2)) (list 1 2 3))
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
    [else (local ((define pivot (first alon)))
            (append (quick-sort< (smallers (rest alon) pivot))
                    (list pivot)
                    (quick-sort< (largers (rest alon) pivot))))]))

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
(define (smallers l n)
  (cond
    [(empty? l) '()]
    [else (if (< (first l) n)
              (cons (first l) (smallers (rest l) n))
              (smallers (rest l) n))]))

