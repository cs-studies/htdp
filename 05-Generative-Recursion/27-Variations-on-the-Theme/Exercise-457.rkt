;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-457) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 457.
;; Design the function double-amount,
;; which computes how many months it takes
;; to double a given amount of money
;; when a savings account pays interest
;; at a fixed rate on a monthly basis.


;; N is one of:
;; - 0
;; - (add1 N)


(define AMOUNT-UNIT 100)


;; N[>=1 <=100] -> N[>=1]
;; Computes a number of months needed to double any amount
;; by applying a compound interest of r each month.
(check-expect (double-amount 100) 1)
(check-expect (double-amount 99) 2)
(check-expect (double-amount 50) 2)
(check-expect (double-amount 10) 8)
(check-expect (double-amount 1) 75)
(check-expect (double-amount 4) 18)
(define (double-amount r)
  (local ((define month-rate (+ 1 (/ r 100)))
          (define doubled (* 2 AMOUNT-UNIT))
          ;; N -> N
          (define (add-rate amount)
            (round (* month-rate amount)))
          ;; N N -> N
          (define (double-amount* a m)
            (cond
              [(>= a doubled) m]
              [else (double-amount* (add-rate a) (add1 m))])))
    (double-amount* (add-rate AMOUNT-UNIT) 1)))


;;; Note
;; More details on a compound interest:
;; https://www.mathsisfun.com/money/compound-interest.html

