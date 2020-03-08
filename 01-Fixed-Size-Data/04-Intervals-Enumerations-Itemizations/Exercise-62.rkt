;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-62) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 62.
;; During a door simulation the "open" state is barely visible.
;; Modify door-simulation so that the clock ticks once every three seconds.
;; Rerun the simulation.

(require 2htdp/universe)
(require 2htdp/image)


;;; Definitions

;; DoorState
(define LOCKED "locked")
(define CLOSED "closed")
(define OPEN "open")

;; KeyEvent
(define UNLOCK "u") ; u key pressed
(define LOCK "l") ; l key pressed
(define PUSH " ") ; space bar pressed


;;; Functions

(define (door-simulation initial-state)
  (big-bang initial-state
    [to-draw door-render]
    [on-tick door-closer 3] ; the clock ticks once every three seconds
    [on-key door-action]))

;; DoorState -> Image
;; Renders a door image according to its state.
(check-expect (door-render CLOSED) (text CLOSED 40 "red"))
(define (door-render state)
  (text state 40 "red"))

;; DoorState -> DoorState
;; Closes an open door during one tick.
(check-expect (door-closer LOCKED) LOCKED)
(check-expect (door-closer CLOSED) CLOSED)
(check-expect (door-closer OPEN) CLOSED)
(define (door-closer state)
  (if (string=? state OPEN) CLOSED state))

;; DoorState KeyEvent -> DoorState
;; Closes/opens a door on a key press.
(check-expect (door-action LOCKED UNLOCK) CLOSED)
(check-expect (door-action CLOSED LOCK) LOCKED)
(check-expect (door-action CLOSED PUSH) OPEN)
(check-expect (door-action OPEN "a") OPEN)
(check-expect (door-action CLOSED "a") CLOSED)
(define (door-action state key)
  (cond
    [(and (string=? state LOCKED) (string=? key UNLOCK)) CLOSED]
    [(and (string=? state CLOSED) (string=? key LOCK)) LOCKED]
    [(and (string=? state CLOSED) (string=? key PUSH)) OPEN]
    [else state]))


;;; Application

;(door-simulation LOCKED)

