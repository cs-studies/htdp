;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-513) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 513.
;; Develop a data representation for the same subset of ISL+
;; that uses structures instead of lists.
;; Also provide data representations for ex1, ex2, and ex3
;; following your data definition.


;; A Lam is one of:
;; – Symbol
;; - LExpr
;; - LApp

(define-struct lexpr [param body])
;; A LExpr is a structure:
;;  (make-struct (list Symbol) Lam)

(define-struct lapp [fun arg])
;; A LApp is a structure:
;;  (make-struct Lam Lam)

(define ex1 (make-lexpr '(x) 'x))
(define ex2 (make-lexpr '(x) 'y))
(define ex3 (make-lexpr '(y) '(λ (x) y)))

