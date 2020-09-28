;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-522) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 522.
;; Modify the representation from exercise 521
;; so that a state records the sequence of states traversed to get there.
;; Use a list of states.
;; Articulate and write down an accumulator statement with the data definition
;; that explains the additional field.
;; Modify final? or render-mc for this representation as needed.


(require 2htdp/image)


;;; Data Definitions

(define MAX 3) ; max number of each actor type.

;; N is a natural number in the interval [0, MAX].

;; A Boat is one of:
;; - 'left
;; - 'right

(define-struct side [mis can])
;; A Side is a structure
;;   (make-side N N)
;; (make-side m c) represents
;; a number of m missionaries and c cannibals on the river bank.

(define-struct ps [left right boat parents])
;; A PuzzleState is a structure
;;   (make-ps Side Side Boat)
;; (make-ps ls rs b) represents a puzzle state
;; with the left side of the river ls,
;; the right side of the river rs,
;; the location of the boat b,
;; and the list of parents p.
;; Accumulator parents contains the list of states traversed,
;; with the most recent one placed on the left.


(define ps-1 (make-ps (make-side 3 3) (make-side 0 0) 'left '()))
(define ps-2 (make-ps (make-side 2 1) (make-side 1 2) 'right (list ps-1)))
(define ps-3 (make-ps (make-side 0 0) (make-side 3 3) 'right (list ps-2 ps-1)))

