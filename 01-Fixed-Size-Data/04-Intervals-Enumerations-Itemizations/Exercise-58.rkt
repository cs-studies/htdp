;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-58) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 58.
;; Introduce constant definitions that separate the intervals
;; for low prices and luxury prices from the others
;; so that the legislators in Tax Land can easily raise the taxes even more.


;; Data Definitions

;; A Price falls into one of three intervals:
;; — 0 through 999
;; — 1000 through 9999
;; — 10000 and above.
;; Represents the price of an item.


;; Constants Definitions

(define LOWER-BOUND-1 1000)
(define LOWER-BOUND-2 10000)

(define RATE-1 0.05)
(define RATE-2 0.08)


;; Functions Definitions

;; Price -> Number
;; Computes the amount of tax charged for a price.
(check-expect (sales-tax 0) 0)
(check-expect (sales-tax 537) 0)
(check-expect (sales-tax 999) 0)
(check-expect (sales-tax LOWER-BOUND-1) (* RATE-1 LOWER-BOUND-1))
(check-expect (sales-tax 1282) (* RATE-1 1282))
(check-expect (sales-tax 9999) (* RATE-1 9999))
(check-expect (sales-tax LOWER-BOUND-2) (* RATE-2 LOWER-BOUND-2))
(check-expect (sales-tax 12017) (* RATE-2 12017))
(define (sales-tax price)
  (cond
    [(and (<= 0 price) (< price LOWER-BOUND-1)) 0]
    [(and (<= LOWER-BOUND-1 price) (< price LOWER-BOUND-2)) (* RATE-1 price)]
    [(>= price LOWER-BOUND-2) (* RATE-2 price)]))

