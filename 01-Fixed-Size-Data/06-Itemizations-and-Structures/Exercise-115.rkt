;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-115) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 115.
;; Revise light=? so that the error message specifies
;; which of the two arguments isn’t an element of TrafficLight.


(define MESSAGE "light=? expects traffic light as the arguments")
(define MESSAGE-1 "light=? expects traffic light as the first argument")
(define MESSAGE-2 "light=? expects traffic light as the second argument")

; Any -> Boolean
; is the given value an element of TrafficLight
(define (light? x)
  (cond
    [(string? x) (or (string=? "red" x)
                     (string=? "green" x)
                     (string=? "yellow" x))]
    [else #false]))

; Any Any -> Boolean
; are the two values elements of TrafficLight and,
; if so, are they equal
(check-expect (light=? "red" "red") #true)
(check-expect (light=? "red" "green") #false)
(check-expect (light=? "green" "green") #true)
(check-expect (light=? "yellow" "yellow") #true)
(check-error (light=? "blue" 1) MESSAGE)
(check-error (light=? 1 "red") MESSAGE-1)
(check-error (light=? "red" "RED") MESSAGE-2)
(define (light=? a-value another-value)
  (if (and (light? a-value) (light? another-value))
      (string=? a-value another-value)
      (error
       (cond
         [(light? a-value) MESSAGE-2]
         [(light? another-value) MESSAGE-1]
         [else MESSAGE]))))

