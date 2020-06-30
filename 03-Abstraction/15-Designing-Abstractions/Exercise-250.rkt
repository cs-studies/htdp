;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-250) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 250.
;; Design tabulate, which is the abstraction of the two functions in figure 92.
;; When tabulate is properly designed, use it to define a tabulation function for sqr and tan.


;; Number Function -> [List-of Number]
;; Tabulates g between n and 0 (incl.) in a list.
(check-expect (tabulate 0 sin) (list 0))
(check-expect (tabulate 0 sqrt) (list 0))
(check-within (tabulate 1 sin) (list (sin 1) 0) 0.001)
(check-within (tabulate 2 sqrt) (list (sqrt 2) 1 0) 0.001)
(define (tabulate n g)
  (cond
    [(= n 0) (list (g 0))]
    [else
     (cons
      (g n)
      (tabulate (sub1 n) g))]))

;; Number -> [List-of Number]
;; Tabulates sqrt between n and 0 (incl.) in a list.
(check-expect (tab-sqrt 0) (list 0))
(check-within (tab-sqrt 2) (list (sqrt 2) 1 0) 0.001)
(define (tab-sqrt n)
  (tabulate n sqrt))

;; Number -> [List-of Number]
;; Tabulates tan between n and 0 (incl.) in a list.
(check-expect (tab-tan 0) (list 0))
(check-within (tab-tan 1) (list (tan 1) 0) 0.001)
(define (tab-tan n)
  (tabulate n tan))

