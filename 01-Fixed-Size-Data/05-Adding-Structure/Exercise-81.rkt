;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-81) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 81.
;; Design the function time->seconds,
;; which consumes instances of time structures
;; and produces the number of seconds
;; that have passed since midnight.


;; A NonnegativeNumber is a Number:
;; - greater than 0
;; - equal to 0.

(define-struct time [hour minute second])
;; A Time is a structure:
;; (make-time NonnegativeNumber NonnegativeNumber NonnegativeNumber)
;; (make-time h m s) represents
;; a point in time since midnight
;; at h hours,
;; m minutes,
;; s seconds.


;; Time -> NonnegativeNumber
;; Converts time to the number of seconds passed since midnight.
(check-expect (time->seconds (make-time 0 0 0)) 0)
(check-expect (time->seconds (make-time 0 0 1)) 1)
(check-expect (time->seconds (make-time 12 30 2)) 45002)
(check-expect (time->seconds (make-time 23 59 59)) (- (* 24 60 60) 1))
(check-expect (time->seconds (make-time 24 00 00)) (* 24 60 60))
(define (time->seconds time)
  (+
   (* (time-hour time) 60 60)
   (* (time-minute time) 60)
   (time-second time)))

