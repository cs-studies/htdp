;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-425) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 425.
;; Articulate purpose statements for smallers and largers in figure 149.


;; [List-of Number] -> [List-of Number]
;; Produces a sorted version of alon.
;; Assumes the numbers are all distinct.
(check-expect (quick-sort< (list 11 9 2 18 12 14 4 1)) (list 1 2 4 9 11 12 14 18))
(define (quick-sort< alon)
  (cond
    [(empty? alon) '()]
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

