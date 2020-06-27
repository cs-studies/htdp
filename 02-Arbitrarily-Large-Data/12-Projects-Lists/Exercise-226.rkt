;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-226) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 226.
;; Design state=?, an equality predicate for states.


(require 2htdp/image)


;; FSM-State is a Color.

(define-struct transition [current next])
;; A Transition is a structure:
;;    (make-transition FSM-State FSM-State)

;; An FSM is one of:
;; - '()
;; - (cons Transition FSM)
;; Represents the transitions that a finite state machine
;; can take from one state to another in reaction to keystrokes.


;; Any -> Boolean
;; Determines whether the given value is an FSM-State.
(check-expect (state=? #true) #false)
(check-expect (state=? 42) #false)
(check-expect (state=? "") #false)
(check-expect (state=? "a") #false)
(check-expect (state=? "red") #true)
(check-expect (state=? "green") #true)
(define (state=? any)
  (and (string? any) (image-color? any)))

