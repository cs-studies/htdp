;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-509) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 509.
;; Design the function split.
;; Use the accumulator design recipe to improve on the result of exercise 508.


(require 2htdp/image)


(define FONT-SIZE 11)
(define FONT-COLOR "red")

;; [List-of 1String] -> Image
;; Renders a string as an image for the editor.
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))

(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor [List-of 1String] [List-of 1String])
;; Interpretation: if (make-editor p s) is the state of
;; an interactive editor, (reverse p) corresponds to
;; the text to the left of the cursor and s to the
;; text on the right.

(define LETTER-WIDTH (image-width (editor-text '("a"))))


;; [List-of 1String] N -> Editor
;; Produces an editor such that x
;; splits editor's pre and post parts.
(check-expect (split '() 10) (make-editor '() '()))
(check-expect (split (explode "abc") 1)
              (make-editor '() (explode "abc")))
(check-expect (split (explode "abc") (+ LETTER-WIDTH 1))
              (make-editor '("a") '("b" "c")))
(check-expect (split (explode "abc") (+ (* 2 LETTER-WIDTH) 1))
              (make-editor '("b" "a") '("c")))
(check-expect (split (explode "abc") (+ (* 3 LETTER-WIDTH) 1))
              (make-editor (explode "cba") '()))
(define (split los x)
  (local ((define (well-placed? pre post)
            (and (<= (image-width (editor-text pre)) x)
                 (or (empty? post)
                     (<= x (image-width (editor-text (cons (first post) pre)))))))

          (define (split* pre post)
            (cond
              [(empty? pre) (make-editor '() los)]
              [(well-placed? pre post) (make-editor pre post)]
              [else (split* (rest pre) (cons (first pre) post))])))

    (split* (reverse los) '())))

