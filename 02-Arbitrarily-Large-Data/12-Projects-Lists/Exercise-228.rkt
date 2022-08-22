;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-228) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 228.
;; Complete the design of find.
;; Use simulate to play with fsm-traffic and the BW Machine from exercise 227.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; FSM-State is a String that specifies a color.

(define-struct transition [current next])
;; A Transition is a structure:
;;    (make-transition FSM-State FSM-State)

;; An FSM is one of:
;; - '()
;; - (cons Transition FSM)
;; Represents the transitions that a finite state machine
;; can take from one state to another in reaction to keystrokes.

(define-struct fs [fsm current])
;; A SimulationState is a structure:
;;   (make-fs FSM FSM-State)


;;; Constants

(define fsm-traffic
  (list (make-transition "red" "green")
        (make-transition "green" "yellow")
        (make-transition "yellow" "red")))

(define BW-Machine
  (list (make-transition "black" "white")
        (make-transition "white" "black")))


;;; Functions

;; FSM FSM-State -> SimulationState
;; Match the keys pressed with the given FSM.
(define (simulate an-fsm s0)
  (big-bang (make-fs an-fsm s0)
    [to-draw render-state]
    [on-key find-next-state]))

;; SimulationState -> Image
;; Renders a world state as an image.
(check-expect (render-state (make-fs fsm-traffic "red")) (square 100 "solid" "red"))
(define (render-state an-fsm)
  (square 100 "solid" (fs-current an-fsm)))

;; SimulationState KeyEvent -> SimulationState
;; Finds the next state from ke and s.
(check-expect (find-next-state (make-fs fsm-traffic "red") "a")
              (make-fs fsm-traffic "green"))
(check-expect (find-next-state (make-fs fsm-traffic "red") "n")
              (make-fs fsm-traffic "green"))
(check-expect (find-next-state (make-fs fsm-traffic "green") "a")
              (make-fs fsm-traffic "yellow"))
(check-expect (find-next-state (make-fs fsm-traffic "green") "q")
              (make-fs fsm-traffic "yellow"))
(check-expect (find-next-state (make-fs fsm-traffic "yellow") "p")
              (make-fs fsm-traffic "red"))
(define (find-next-state an-fsm ke)
  (make-fs
   (fs-fsm an-fsm)
   (find (fs-fsm an-fsm) (fs-current an-fsm))))

;; FSM FSM-State -> FSM-State
;; Finds the state representing current in transitions
;; and retrieves the next field.
(check-error (find '() "red") "not found: red")
(check-error (find BW-Machine "red") "not found: red")
(check-expect (find BW-Machine "black") "white")
(check-expect (find fsm-traffic "red") "green")
(check-expect (find fsm-traffic "green") "yellow")
(check-expect (find fsm-traffic "yellow") "red")
(check-error (find fsm-traffic "black") "not found: black")
(define (find transitions current)
  (cond
    [(empty? transitions) (error (string-append "not found: " current))]
    [else (if (state=? (transition-current (first transitions)) current)
              (transition-next (first transitions))
              (find (rest transitions) current))]))

;; FSM-State FSM-State -> Boolean
;; Verifies equality of two FSM-States.
(check-expect (state=? "red" "green") #false)
(check-expect (state=? "red" "red") #true)
(define (state=? s1 s2)
  (string=? s1 s2))


;;; Application

;(simulate fsm-traffic "red")

;(simulate BW-Machine "black")

