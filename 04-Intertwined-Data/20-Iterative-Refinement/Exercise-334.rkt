;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-334) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 334.
;; Show how to equip a directory with two more attributes: size and readability.
;; The former measures how much space the directory itself
;; (as opposed to its content) consumes;
;; the latter specifies whether anyone else besides the user
;; may browse the content of the directory.


;; A File is a String.

;; An LOFD (short for list of files and directories) is one of:
;; – '()
;; – (cons File LOFD)
;; – (cons Dir LOFD)

(define-struct dir [name content size r])
;; A Dir is a structure:
;;   (make-dir String LOFD Number Boolean)
;; (make-dir n l s r) represents a directory
;; with the name n, content l, size s,
;; and readability status r.

