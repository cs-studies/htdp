;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-381) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 381.
;; The definitions of XMachine and X1T use quote,
;; which is highly inappropriate for novice program designers.
;; Rewrite them first to use list and then cons.


;; An FSM-State is a String that specifies a color.


;; An XT is a nested list of this shape:
;;   `(action ((state ,FSM-State) (next ,FSM-State)))
;; ==
;;    (list 'action (list (list 'state FSM-State)) (list 'next FSM-State))
;; ==
;; (cons 'action
;;       (cons
;;        (cons (cons 'state (cons FSM-State '())) '())
;;        (cons (cons 'next (cons FSM-State '())) '())))


;; An XMachine is a nested list of this shape:
;;   `(machine ((initial ,FSM-State)) [List-of XT])
;; ==
;; (list 'machine (list (list 'initial FSM-State)) [List-of XT])
;; ==
;; (cons 'machine
;;       (cons
;;        (cons (cons 'initial (cons FSM-State '())) '())
;;        (cons [List-of XT] '())))

