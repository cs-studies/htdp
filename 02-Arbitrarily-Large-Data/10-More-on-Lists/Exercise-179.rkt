;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-179) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 179.
;; Design the auxiliary functions editor-lft, editor-rgt, editor-del.


;;; Data Definitions

;; An Lo1S is one of:
;; - '()
;; - (cons 1String Lo1S)

(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor Lo1S Lo1S)


;;; Functions

;; Editor –> Editor
;; Moves the cursor position one 1String left, if possible.
(check-expect (editor-left (make-editor '() '())) (make-editor '() '()))
(check-expect (editor-left (make-editor '() (cons "a" '())))
              (make-editor '() (cons "a" '())))
(check-expect (editor-left (make-editor (cons "a" '()) '()))
              (make-editor '() (cons "a" '())))
(check-expect (editor-left (make-editor (cons "b" (cons "a" '())) (cons  "c" '())))
              (make-editor (cons "a" '()) (cons "b" (cons "c" '()))))
#|
;; Template
(define (editor-left ed)
  (... (editor-pre ed) ... (editor-post ed) ...))
|#
(define (editor-left ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed))
                   (cons (first (editor-pre ed)) (editor-post ed)))))


;; Editor –> Editor
;; Moves the cursor position one 1String right, if possible.
(check-expect (editor-right (make-editor '() '())) (make-editor '() '()))
(check-expect (editor-right (make-editor (cons "a" '()) '()))
              (make-editor (cons "a" '()) '()))
(check-expect (editor-right (make-editor '() (cons "a" '())))
              (make-editor (cons "a" '()) '()))
(check-expect (editor-right (make-editor (cons "b" (cons "a" '())) (cons  "c" '())))
              (make-editor (cons "c" (cons "b" (cons "a" '()))) '()))
#|
;; Template
(define (editor-right ed)
  (... (editor-pre ed) ... (editor-post ed) ...))
|#
(define (editor-right ed)
  (if (empty? (editor-post ed))
      ed
      (make-editor (cons (first (editor-post ed)) (editor-pre ed))
                   (rest (editor-post ed)))))


;; Editor –> Editor
;; Deletes a character to the left of the cursor, if possible.
(check-expect (editor-delete (make-editor '() '())) (make-editor '() '()))
(check-expect (editor-delete (make-editor (cons "a" '()) '()))
              (make-editor '() '()))
(check-expect (editor-delete (make-editor '() (cons "a" '())))
              (make-editor '() (cons "a" '())))
(check-expect (editor-delete (make-editor (cons "b" (cons "a" '())) (cons  "c" '())))
              (make-editor (cons "a" '()) (cons "c" '())))
#|
;; Template
(define (editor-delete ed)
  (... (editor-pre ed) ... (editor-post ed) ...))
|#
(define (editor-delete ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed))
                   (editor-post ed))))

