;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-180) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 180.
;; Design editor-text without using implode.


(require 2htdp/image)


;;; Data Definitions

;; An Lo1S is one of:
;; - '()
;; - (cons 1String Lo1S)

(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor Lo1S Lo1S)


;;; Constants

(define FONT-SIZE 16)
(define FONT-COLOR "white")


;;; Functions

;; Lo1S -> Image
;; Renders a list of 1Strings as a text image.
(check-expect (editor-text '()) (text "" FONT-SIZE FONT-COLOR))
(check-expect (editor-text (cons "e" (cons "r" (cons "p" '()))))
              (text "erp" FONT-SIZE FONT-COLOR))
(check-expect (editor-text (cons "p" (cons "o" (cons "s" (cons "t" '())))))
              (text "post" FONT-SIZE FONT-COLOR))
(define (editor-text s)
  (text (editor-implode s) FONT-SIZE FONT-COLOR))

;; Lo1S -> String
;; Concatenates the list of 1-letter strings into one string.
(check-expect (editor-implode '()) "")
(check-expect (editor-implode (cons "p" (cons "o" (cons "s" (cons "t" '()))))) "post")
(define (editor-implode s)
  (cond
    [(empty? s) ""]
    [else (string-append (first s) (editor-implode (rest s)))]))

