;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-378) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 378.
;; Modify the rendering function
;; so that it overlays the name of the state
;; onto the colored square.


(require 2htdp/universe)
(require 2htdp/image)


;; An FSM-State is a String that specifies a color.

;; A Transition is a list of two items:
;;   (cons FSM-State (cons FSM-State '()))

;; An FSM is a [List-of Transition]

;; Data examples
(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))

;; FSM FSM-State -> FSM-State
;; Matches the keys pressed by a player with the given FSM.
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
    [to-draw
      (lambda (current)
        (overlay (text current 14 "black") (square 100 "solid" current)))]
    [on-key
      (lambda (current key-event)
        (find transitions current))]))

;; [X Y] [List-of [List X Y]] X -> Y
;; Finds the matching Y for the given X in alist.
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))


;;; Application

;(simulate "red" fsm-traffic)

