;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-383) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 383.
;; Run the code in figure 130 with the BW Machine configuration from exercise 382.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; An FSM-State is a String that specifies a color.

;; A Transition is a list of two items:
;;   (cons FSM-State (cons FSM-State '()))

;; An FSM is a [List-of Transition]

;; An XT is a nested list of this shape:
;;   `(action ((state ,FSM-State) (next ,FSM-State)))

;; An XMachine is a nested list of this shape:
;;   `(machine ((initial ,FSM-State)) [List-of XT])

;; An Xexpr is a list:
;; – (cons Symbol Body)
;; – (cons Symbol (cons [List-of Attribute] Body))
;; where Body is short for [List-of Xexpr]
;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))

;; An Attrs-or-Xexpr is one of:
;; - [List-of Attribute]
;; - Xexpr


;;; Constants

(define xm0
  '(machine ((initial "red"))
            (action ((state "red") (next "green")))
            (action ((state "green") (next "yellow")))
            (action ((state "yellow") (next "red")))))

(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))

(define xm1
  '(machine ((initial "white"))
            (action ((state "white") (next "black")))
            (action ((state "black") (next "white")))))

(define black-white
  '(("white" "black") ("black" "white")))


;;; Functions

;; XMachine -> FSM-State
;; Simulates an FSM via the given configuration.
(define (simulate-xmachine xm)
  (simulate (xm-state0 xm) (xm->transitions xm)))

;; XMachine -> FSM-State
;; Extracts the initial state of xm.
(check-expect (xm-state0 xm0) "red")
(check-expect (xm-state0 xm1) "white")
(define (xm-state0 xm)
  (find-attr (xexpr-attr xm) 'initial))

;; XMachine -> [List-of Transition]
;; Extracts the transition table of xm.
(check-expect (xm->transitions xm0) fsm-traffic)
(check-expect (xm->transitions xm1) black-white)
(define (xm->transitions xm)
  (local (;; XT -> Transition
          (define (xaction->action xa)
            (list (find-attr (xexpr-attr xa) 'state)
                  (find-attr (xexpr-attr xa) 'next))))
    (map xaction->action (xexpr-content xm))))

;; FSM FSM-State -> FSM-State
;; Matches the keys pressed by a player with the given FSM.
(define (simulate state0 transitions)
  (big-bang state0 ; FSM-State
    [to-draw
     (lambda (current)
       (square 100 "solid" current))]
    [on-key
     (lambda (current key-event)
       (find transitions current))]))

;; [X Y] [List-of [List X Y]] X -> Y
;; Finds the matching Y for the given X in alist.
(check-expect (find fsm-traffic "red") "green")
(check-expect (find fsm-traffic "green") "yellow")
(check-expect (find fsm-traffic "yellow") "red")
(check-error (find fsm-traffic "black") "not found")
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "not found"))))

;; [List-of Attribute] Symbol -> [Maybe String]
;; Retrieves a string associated with s from loa.
(define (find-attr loa s)
  (local ((define found (assq s loa)))
    (if (false? found)
        #false
        (second found))))

;; Xexpr -> [List-of Attribute]
;; Retrieves the list of attributes of xe.
(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

;; Attrs-or-Xexpr -> Boolean
;; Determines whether x is an element of [List-of Attribute].
;; Otherwise produces #false.
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

;; Xexpr -> [List-of Xexpr]
;; Retrieves the list of content elements.
(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (if (list-of-attributes? (first optional-loa+content))
           (rest optional-loa+content)
           optional-loa+content)])))


;;; Application

;(simulate-xmachine xm1)

