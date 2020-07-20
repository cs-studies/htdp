;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-109) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 109.
;; Design a world program that recognizes a pattern in a sequence of KeyEvents.


(require 2htdp/universe)
(require 2htdp/image)


;;; Constants and Data Definitions

;; A KeyEvent is one of:
;; - "a"
;; - "b"
;; - "c"
;; - "d"
;; Represents key presses.

(define AA "white")
(define BB "yellow")
(define DD "green")
(define ER "red")

;; An FSMState is one of:
;; – AA
;; – BB
;; – DD
;; – ER
;; Represents states of the finite state machine with
;; each state reached in a particular order on these events:
;; - AA on the initial "a" key press,
;; followed by
;; - BB on any number of "b" and "c" key presses,
;; - DD on "d" key press;
;; - and ER on not accepted key press.
;; The finite state machine with these states can be represented
;; by this regular expression:  a (b|c)* d


;;; Constants

(define WIDTH 100)
(define HEIGHT 100)


;;; Functions

;; FSMState -> FSMState
;; Usage: (fsm AA)
(define (fsm s)
  (big-bang s
    [to-draw render]
    [on-key switch-state]))

;; FSMState -> Image
;; Renders an image corresponding to the current world state.
(check-expect (render AA) (rectangle WIDTH HEIGHT "solid" "white"))
(check-expect (render BB) (rectangle WIDTH HEIGHT "solid" "yellow"))
(check-expect (render DD) (rectangle WIDTH HEIGHT "solid" "green"))
(check-expect (render ER) (rectangle WIDTH HEIGHT "solid" "red"))
(define (render s)
  (rectangle WIDTH HEIGHT "solid" s))

;; FSMState KeyEvent -> FSMState
;; Changes state of the finite state machine on a key press.
(check-expect (switch-state AA "a") BB)
(check-expect (switch-state AA "b") ER)
(check-expect (switch-state BB "b") BB)
(check-expect (switch-state BB "c") BB)
(check-expect (switch-state BB "d") DD)
(check-expect (switch-state BB "a") ER)
(define (switch-state s key)
  (cond
    [(string=? s AA)
     (if (key=? key "a") BB ER)]
    [(string=? s BB)
     (cond
       [(or (key=? key "b") (key=? key "c")) BB]
       [(key=? key "d") DD]
       [else ER])]
    [else s]))


;;; Application

;; (fsm AA)

