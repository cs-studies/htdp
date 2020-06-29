;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-240) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 240.
;; Make examples for the LStr and LNum.
;; Abstract over the two.
;; Then instantiate the abstract definition to get back the originals.


(define-struct layer [stuff])

;; An LStr is one of:
;; – String
;; – (make-layer LStr)


;; An LNum is one of:
;; – Number
;; – (make-layer LNum)

(define lstr-1 "hello")
(define lstr-2 (make-layer lstr-1))
(define lstr-3 (make-layer lstr-2))

(define lnum-1 42)
(define lnum-2 (make-layer lnum-1))
(define lnum-3 (make-layer lnum-2))

;; A [Layer-of ITEM] is one of:
;; - ITEM
;; - (make-layer [Layer-of ITEM])

;; An LStr is a [Layer-of String]

;; An LNum is a [Layer-of Number]

