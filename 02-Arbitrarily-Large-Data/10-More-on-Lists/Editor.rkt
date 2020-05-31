;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; An Lo1S is one of:
;; - '()
;; - (cons 1String Lo1S)

(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor Lo1S Lo1S)


;;; Constants

(define HEIGHT 20) ; the height of the editor
(define WIDTH 200) ; the width of the editor
(define FONT-SIZE 16)
(define FONT-COLOR "black")

(define SCENE (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

;; Unit Tests
(define ED-200 (make-editor (reverse (explode (make-string 200 #\a))) '()))


;;; Functions

;; String -> Editor
;; Launches the editor given some initial string.
;; Usage: (main "abc")
(define (main s)
  (big-bang (create-editor s "")
    [to-draw editor-render]
    [on-key editor-kh]))

;; String String -> Editor
;; Produces an Editor.
(check-expect (create-editor "" "") (make-editor '() '()))
(check-expect (create-editor "a" "") (make-editor (cons "a" '()) '()))
(check-expect (create-editor "ab" "c") (make-editor (cons "b" (cons "a" '())) (cons "c" '())))
(define (create-editor s-pre s-post)
  (make-editor (reverse (explode s-pre)) (explode s-post)))

;; Editor -> Image
;; Renders an editor as an image of the two texts
;; separated by the cursor.
(define (editor-render ed)
  (place-image/align
   (beside (editor-text (reverse (editor-pre ed)))
           CURSOR
           (editor-text (editor-post ed)))
   1 1
   "left" "top"
   SCENE))

;; Lo1S -> Image
;; Renders a list of 1Strings as a text image.
(check-expect (editor-text '()) (text "" FONT-SIZE FONT-COLOR))
(check-expect (editor-text (cons "e" (cons "r" (cons "p" '()))))
              (text "erp" FONT-SIZE FONT-COLOR))
(check-expect (editor-text (cons "p" (cons "o" (cons "s" (cons "t" '())))))
              (text "post" FONT-SIZE FONT-COLOR))
(define (editor-text s)
  (text (implode s) FONT-SIZE FONT-COLOR))

;; Editor KeyEvent -> Editor
;; Deals with a key event, given some editor.
(check-expect (editor-kh (create-editor "" "") "e") (create-editor "e" ""))
(check-expect (editor-kh (create-editor "cd" "fgh") "e") (create-editor "cde" "fgh"))
(check-expect (editor-kh (create-editor "" "") "\b") (create-editor "" ""))
(check-expect (editor-kh (create-editor "a" "") "\b") (create-editor "" ""))
(check-expect (editor-kh (create-editor "" "b") "\b") (create-editor "" "b"))
(check-expect (editor-kh (create-editor "ab" "cd") "\b") (create-editor "a" "cd"))
(check-expect (editor-kh (create-editor "ab" "cd") "\t") (create-editor "ab" "cd"))
(check-expect (editor-kh (create-editor "ab" "cd") "\r") (create-editor "ab" "cd"))
(check-expect (editor-kh (create-editor "" "") "left") (create-editor "" ""))
(check-expect (editor-kh (create-editor "a" "") "left") (create-editor "" "a"))
(check-expect (editor-kh (create-editor "" "b") "left") (create-editor "" "b"))
(check-expect (editor-kh (create-editor "ab" "cd") "left") (create-editor "a" "bcd"))
(check-expect (editor-kh (create-editor "" "") "right") (create-editor "" ""))
(check-expect (editor-kh (create-editor "a" "") "right") (create-editor "a" ""))
(check-expect (editor-kh (create-editor "" "b") "right") (create-editor "b" ""))
(check-expect (editor-kh (create-editor "ab" "cd") "right") (create-editor "abc" "d"))
(check-expect (editor-kh (create-editor "ab" "cd") "up") (create-editor "ab" "cd"))
(check-expect (editor-kh (create-editor "ab" "cd") "down") (create-editor "ab" "cd"))
(define (editor-kh ed k)
  (cond
    [(key=? k "left") (editor-left ed)]
    [(key=? k "right") (editor-right ed)]
    [(key=? k "\b") (editor-delete ed)]
    [(key=? k "\t") ed]
    [(key=? k "\r") ed]
    [(= (string-length k) 1) (editor-insert ed k)]
    [else ed]))

;; Editor –> Editor
;; Moves the cursor position one 1String left, if possible.
(check-expect (editor-left (make-editor '() '())) (make-editor '() '()))
(check-expect (editor-left (make-editor '() (cons "a" '())))
              (make-editor '() (cons "a" '())))
(check-expect (editor-left (make-editor (cons "a" '()) '()))
              (make-editor '() (cons "a" '())))
(check-expect (editor-left (make-editor (cons "b" (cons "a" '())) (cons  "c" '())))
              (make-editor (cons "a" '()) (cons "b" (cons "c" '()))))
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
(define (editor-delete ed)
  (if (empty? (editor-pre ed))
      ed
      (make-editor (rest (editor-pre ed))
                   (editor-post ed))))


;; Editor 1String –> Editor
;; Inserts a new character into the editor.
(check-expect (editor-insert (make-editor '() '()) "e") (make-editor (cons "e" '()) '()))
(check-expect (editor-insert (make-editor (cons "d" '()) (cons "f" (cons "g" '()))) "e")
              (make-editor (cons "e" (cons "d" '())) (cons "f" (cons "g" '()))))
(check-expect (editor-insert ED-200 "a") ED-200)
(define (editor-insert ed char)
  (if (can-insert? ed)
      (make-editor (cons char (editor-pre ed)) (editor-post ed))
      ed))

;; Editor -> Boolean
;; Identifies if an editor has capacity for more letters.
(check-expect (can-insert? (create-editor "" "")) #true)
(check-expect (can-insert? (create-editor "ab" "cd")) #true)
(check-expect (can-insert? ED-200) #false)
(define (can-insert? ed)
       (<
        (image-width (editor-text (append (editor-pre ed) (editor-post ed))))
        (- WIDTH 7)))


;;; Application

;(main "abc")

