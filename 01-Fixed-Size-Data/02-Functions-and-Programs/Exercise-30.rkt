;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-30) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 30.
;; Define constants for the price optimization program at the movie theater
;; so that the price sensitivity of attendance (15 people for every 10 cents)
;; becomes a computed constant.

;; Definitions
(define BASE-PRICE 5.0) ; dollars
(define BASE-ATTENDEES 120) ; number of people
(define PRICE-AFFORDABILITY (/ 15 0.1)) ; number of people per price change in dollars
(define ATTENDEE-COST 1.5) ; dollars

(define (attendees ticket-price)
  (- BASE-ATTENDEES (* (- ticket-price BASE-PRICE) PRICE-AFFORDABILITY)))

(define (revenue ticket-price)
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price)
  (* ATTENDEE-COST (attendees ticket-price)))

(define (profit ticket-price)
  (- (revenue ticket-price)
     (cost ticket-price)))

;; Application
(profit 3)
(profit 4)
(profit 5)

