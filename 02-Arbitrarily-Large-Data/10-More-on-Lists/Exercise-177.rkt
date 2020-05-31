;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-177) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 177.
;; Design the function create-editor.
;; The function consumes two strings and produces an Editor.
;; The first string is the text to the left of the cursor
;; and the second string is the text to the right of the cursor.


;; An Lo1S is one of:
;; - '()
;; - (cons 1String Lo1S)

(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor Lo1S Lo1S)


;; String String -> Editor
;; Produces an Editor.
(check-expect (create-editor "" "") (make-editor '() '()))
(check-expect (create-editor "a" "") (make-editor (cons "a" '()) '()))
(check-expect (create-editor "ab" "c") (make-editor (cons "a" (cons "b" '())) (cons "c" '())))
(define (create-editor s-pre s-post)
  (make-editor (explode s-pre) (explode s-post)))

