;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 2.
;; Add the following two lines to the definitions area:
;; (define prefix "hello")
;; (define suffix "world")
;; Then use string primitives to create an expression
;; that concatenates prefix and suffix and adds "_" between them.
;; When you run this program, you will see "hello_world" in the interactions area.

;; Definitions
(define prefix "hello")
(define suffix "world")

;; Application
(string-append prefix "_" suffix)

