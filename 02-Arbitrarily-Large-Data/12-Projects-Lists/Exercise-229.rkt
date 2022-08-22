;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-229) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 229.
;; Represent the FSM from exercise 109
;; using lists of revised data definition for Transition;
;; ignore errors and final states.
;; Modify the design of simulate so that it deals with keystrokes
;; in the appropriate manner now.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; FSM-State is a String that specifies a color.

(define-struct transition [current key next])
;; A Transition is a structure:
;;    (make-transition FSM-State KeyEvent FSM-State)

;; An FSM is one of:
;; - '()
;; - (cons Transition FSM)
;; Represents the transitions that a finite state machine
;; can take from one state to another in reaction to keystrokes.

(define-struct fs [fsm current])
;; A SimulationState is a structure:
;;   (make-fs FSM FSM-State)


;;; Constants

(define fsm-109
  (list (make-transition "white" "a" "yellow")
        (make-transition "yellow" "b" "yellow")
        (make-transition "yellow" "c" "yellow")
        (make-transition "yellow" "d" "green")))


;;; Functions

;; FSM FSM-State -> SimulationState
;; Match the keys pressed with the given FSM.
(define (simulate an-fsm s0)
  (big-bang (make-fs an-fsm s0)
    [to-draw render-state]
    [on-key find-next-state]))

;; SimulationState -> Image
;; Renders a world state as an image.
(check-expect (render-state (make-fs fsm-109 "yellow")) (square 100 "solid" "yellow"))
(define (render-state an-fsm)
  (square 100 "solid" (fs-current an-fsm)))

;; SimulationState KeyEvent -> SimulationState
;; Finds the next state from ke and s.
(check-expect (find-next-state (make-fs fsm-109 "white") "p")
              (make-fs fsm-109 "white"))
(check-expect (find-next-state (make-fs fsm-109 "white") "a")
              (make-fs fsm-109 "yellow"))
(check-expect (find-next-state (make-fs fsm-109 "yellow") "a")
              (make-fs fsm-109 "yellow"))
(check-expect (find-next-state (make-fs fsm-109 "yellow") "b")
              (make-fs fsm-109 "yellow"))
(check-expect (find-next-state (make-fs fsm-109 "yellow") "c")
              (make-fs fsm-109 "yellow"))
(check-expect (find-next-state (make-fs fsm-109 "yellow") "d")
              (make-fs fsm-109 "green"))
(define (find-next-state an-fsm ke)
  (make-fs
   (fs-fsm an-fsm)
   (find (fs-fsm an-fsm) (fs-current an-fsm) ke)))

;; FSM FSM-State KeyEvent -> FSM-State
;; Finds the state representing current in transitions
;; and retrieves the next field.
(check-expect (find '() "white" "p") "white")
(check-expect (find fsm-109 "white" "a") "yellow")
(check-expect (find fsm-109 "yellow" "a") "yellow")
(check-expect (find fsm-109 "yellow" "d") "green")
(define (find transitions current ke)
  (cond
    [(empty? transitions) current]
    [else (if (and
               (state=? (transition-current (first transitions)) current)
               (key=? (transition-key (first transitions)) ke))
              (transition-next (first transitions))
              (find (rest transitions) current ke))]))

;; FSM-State FSM-State -> Boolean
;; Verifies equality of two FSM-States.
(check-expect (state=? "red" "green") #false)
(check-expect (state=? "red" "red") #true)
(define (state=? s1 s2)
  (string=? s1 s2))


;;; Application

;(simulate fsm-109 "white") ; click "a", "b", "b", "c", "d"

