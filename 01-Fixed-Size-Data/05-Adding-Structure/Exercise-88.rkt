;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-88) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 88.
;; Define a structure type
;; that keeps track of the cat’s x-coordinate and its happiness.
;; Then formulate a data definition for cats, dubbed VCat,
;; including an interpretation.


;; A Score is a Number
;; in an interval [0, 100]
;; Represents a happiness level.

(define-struct vCat [x score])
;; A VCat is a structure:
;; (make-vCat Number Score)
;; (make-vCat x s) represents a walking cat
;; which is located on an x-coordinate x and
;; has a happiness level s.

