;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-110) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 110.
;; A checked version of area-of-disk can also enforce
;; that the arguments to the function are positive numbers,
;; not just arbitrary numbers.
;; Modify checked-area-of-disk in this way.


(define MESSAGE "area-of-disk: positive number expected")

;; Number -> Number
;; Computes the area of a disk with radius r.
(define (area-of-disk r)
  (* 3.14 (* r r)))

;; Any -> Number
;; Checks that v is a proper input for function area-of-disk.
(check-expect (checked-area-of-disk 1) 3.14)
(check-error (checked-area-of-disk 0) MESSAGE)
(check-error (checked-area-of-disk -1) MESSAGE)
(check-error (checked-area-of-disk "a") MESSAGE)
(define (checked-area-of-disk v)
  (cond
    [(and (number? v) (> v 0))
     (area-of-disk v)]
    [else
     (error MESSAGE)]))

