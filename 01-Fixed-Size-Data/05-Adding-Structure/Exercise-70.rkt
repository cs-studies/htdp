;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-70) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 70.
;; Spell out the laws for these structure type definitions:

(define-struct centry [name home office cell])
(define-struct phone [area number])

;; centry Laws
; (centry-name (make-centry n0 h0 o0 c0)) == n0
; (centry-home (make-centry n0 h0 o0 c0)) == h0
; (centry-office (make-centry n0 h0 o0 c0)) == o0
; (centry-cell (make-centry n0 h0 o0 c0)) == c0


;; phone Laws
; (phone-area (make-phone a0 n0)) == a0
; (phone-number (make-phone a0 n0)) == n0

