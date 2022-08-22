;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-230) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 230.
;; Consider the revised data representation for FSMs.
;; Represent the FSM from exercise 109 in this context.
;; Design the function fsm-simulate.
;; If the sequence of keystrokes forces the revised FSM to reach a final state,
;; fsm-simulate stops.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; FSM-State is a String that specifies a color.

(define-struct transition [current key next])
;; A Transition is a structure:
;;    (make-transition FSM-State KeyEvent FSM-State)

;; An LOT is one of:
;; - '()
;; - (cons Transition LOT)

(define-struct fsm [initial transitions final])
;; An FSM is a structure:
;;   (make-fsm (FSM-State LOT FSM-State)


;;; Constants

(define transitions
  (list (make-transition "white" "a" "yellow")
        (make-transition "yellow" "b" "yellow")
        (make-transition "yellow" "c" "yellow")
        (make-transition "yellow" "d" "green")))

(define fsm-109 (make-fsm "white" transitions "green"))


;;; Functions

;; FSM -> FSM
;; Match the keys pressed with the given FSM.
(define (fsm-simulate an-fsm)
  (big-bang an-fsm
    [to-draw render-state]
    [on-key find-next-state]
    [stop-when end? render-final-state]))

;; FSM -> Image
;; Renders a world state as an image.
(check-expect (render-state fsm-109) (square 100 "solid" "white"))
(define (render-state an-fsm)
  (square 100 "solid" (fsm-initial an-fsm)))

;; FSM KeyEvent -> FSM
;; Finds the next state from ke and s.
(check-expect (find-next-state fsm-109 "p") fsm-109)
(check-expect (find-next-state fsm-109 "a") (make-fsm "yellow" transitions "green"))
(check-expect (find-next-state (make-fsm "yellow" transitions "green") "b")
              (make-fsm "yellow" transitions "green"))
(check-expect (find-next-state (make-fsm "yellow" transitions "green") "c")
              (make-fsm "yellow" transitions "green"))
(check-expect (find-next-state (make-fsm "yellow" transitions "green") "d")
              (make-fsm "green" transitions "green"))
(define (find-next-state an-fsm ke)
  (make-fsm
   (find (fsm-transitions an-fsm) (fsm-initial an-fsm) ke)
   (fsm-transitions an-fsm)
   (fsm-final an-fsm)))


;; LOT FSM-State KeyEvent -> FSM-State
;; Finds the state representing current in transitions
;; and retrieves the next field.
(check-expect (find transitions "white" "d") "white")
(check-expect (find transitions "white" "a") "yellow")
(check-expect (find transitions "yellow" "b") "yellow")
(check-expect (find transitions "yellow" "d") "green")
(define (find transitions current ke)
  (cond
    [(empty? transitions) current]
    [else (if (and
               (state=? (transition-current (first transitions)) current)
               (key=? (transition-key (first transitions)) ke))
              (transition-next (first transitions))
              (find (rest transitions) current ke))]))

;; FSM -> Boolean
;; Determines whether a final state has been reached.
(check-expect (end? fsm-109) #false)
(check-expect (end? (make-fsm "yellow" transitions "green")) #false)
(check-expect (end? (make-fsm "green" transitions "green")) #true)
(define (end? an-fsm)
  (state=? (fsm-initial an-fsm) (fsm-final an-fsm)))

;; FSM -> Image
;; Produces the last scene.
(check-expect (render-final-state fsm-109) (render-state fsm-109))
(define (render-final-state an-fsm)
  (render-state an-fsm))

;; FSM-State FSM-State -> Boolean
;; Verifies equality of two FSM-States.
(check-expect (state=? "red" "green") #false)
(check-expect (state=? "red" "red") #true)
(define (state=? s1 s2)
  (string=? s1 s2))


;;; Application

;(fsm-simulate fsm-109)

