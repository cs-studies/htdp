;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-87) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 87.
;; Develop a data representation for an editor based on our first idea,
;; using a string and an index.
;;
;; Exercise 114.
;; Use the predicates from exercise 113 to check
;; ... the editor program (A Graphical Editor).


(require 2htdp/universe)
(require 2htdp/image)


;;; Constants and Data Definitions

;; An Index is a Number
;; greater than 0 or equal to 0.
;; Represents a position in a string.

(define-struct editor [content cursor-at])
;; An Editor is a structure:
;;   (make-editor String Index)
;; (make-editor s i) describes an editor with
;; - the visible text s,
;; - the cursor at Index i.

(define CURSOR-WIDTH 1)
(define CURSOR-HEIGHT 20)
(define CURSOR-COLOR "red")

(define TEXT-SIZE 16)
(define TEXT-COLOR "black")

(define SCENE-WIDTH 200)
(define SCENE-HEIGHT 20)

(define CURSOR (rectangle CURSOR-WIDTH CURSOR-HEIGHT "solid" CURSOR-COLOR))
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT))

;; For Tests Only
(define ed-0 (make-editor "hi-fi" 0))
(define ed-3 (make-editor "hi-fi" 3))
(define ed-5 (make-editor "hi-fi" 5))
(define ed-200 (make-editor (make-string 200 #\a) 200))
(define ed-empty (make-editor "" 0))


;; Functions

;; Editor -> Editor
;; Launches an interactive editor.
;; Usage: (run (make-editor "hi-fi" 3))
(define (run ed)
  (big-bang ed
    [to-draw render]
    [check-with editor?] ; exercise 114
    [on-key edit]))

;; Editor -> Image
;; Renders an editor image.
(check-expect (render (make-editor "hi-fi" 3))
              (overlay/align
               "left" "center"
               (beside (draw-text "hi-") CURSOR (draw-text "fi"))
               SCENE))
(define (render ed)
  (overlay/align
   "left" "center"
   (beside
    (draw-text (substring (editor-content ed) 0 (editor-cursor-at ed)))
    CURSOR
    (draw-text (substring (editor-content ed) (editor-cursor-at ed))))
   SCENE))

;; String -> Image
;; Constructs an image that draws the given string.
(check-expect (draw-text "hi-fi") (text "hi-fi" TEXT-SIZE TEXT-COLOR))
(define (draw-text str)
  (text str TEXT-SIZE TEXT-COLOR))

;; Editor KeyEvent -> Editor
;; Produces an editor based on given parameters.
(check-expect (edit ed-0 "a") (make-editor "ahi-fi" 1))
(check-expect (edit ed-3 "a") (make-editor "hi-afi" 4))
(check-expect (edit ed-5 "a") (make-editor "hi-fia" 6))
(check-expect (edit ed-empty "a") (make-editor "a" 1))
(check-expect (edit ed-200 "b") ed-200)
(check-expect (edit ed-0 " ") (make-editor " hi-fi" 1))
(check-expect (edit ed-3 " ") (make-editor "hi- fi" 4))
(check-expect (edit ed-5 " ") (make-editor "hi-fi " 6))
(check-expect (edit ed-empty " ") (make-editor " " 1))
(check-expect (edit ed-0 "\b") (make-editor "hi-fi" 0))
(check-expect (edit ed-3 "\b") (make-editor "hifi" 2))
(check-expect (edit ed-5 "\b") (make-editor "hi-f" 4))
(check-expect (edit ed-empty "\b") ed-empty)
(check-expect (edit ed-0 "") ed-0)
(check-expect (edit ed-3 "\t") ed-3)
(check-expect (edit ed-5 "\r") ed-5)
(check-expect (edit ed-empty "") ed-empty)
(check-expect (edit ed-0 "left") ed-0)
(check-expect (edit ed-3 "left") (make-editor "hi-fi" 2))
(check-expect (edit ed-5 "left") (make-editor "hi-fi" 4))
(check-expect (edit ed-empty "") ed-empty)
(check-expect (edit ed-0 "right") (make-editor "hi-fi" 1))
(check-expect (edit ed-3 "right") (make-editor "hi-fi" 4))
(check-expect (edit ed-5 "right") ed-5)
(check-expect (edit ed-empty "") ed-empty)
(define (edit ed ke)
  (cond
    [(string=? ke "left") (make-editor
                           (editor-content ed)
                           (index-1 ed))]
    [(string=? ke "right") (make-editor
                            (editor-content ed)
                            (index+1 ed))]
    [(string=? ke "\b") (make-editor
                        (delete-char ed)
                        (index-1 ed))]
    [(insert? ed ke) (make-editor
                      (insert-char ed ke)
                      (+ (editor-cursor-at ed) 1))]
    [else ed]))


;; Editor -> Index
;; Calculates decreased index value.
(check-expect (index-1 (make-editor "" 0)) 0)
(check-expect (index-1 (make-editor "" 3)) 2)
(define (index-1 ed)
  (if (> (editor-cursor-at ed) 0)
      (- (editor-cursor-at ed) 1)
      0))

;; Editor -> Index
;; Calculates increased index value.
(check-expect (index+1 ed-0) 1)
(check-expect (index+1 ed-3) 4)
(check-expect (index+1 ed-5) 5)
(define (index+1 ed)
  (if (< (editor-cursor-at ed) (string-length (editor-content ed)))
      (+ (editor-cursor-at ed) 1)
      (editor-cursor-at ed)))

;; Editor -> String
;; Deletes a character from an editor content.
(check-expect (delete-char ed-0) "hi-fi")
(check-expect (delete-char ed-3) "hifi")
(check-expect (delete-char ed-5) "hi-f")
(check-expect (delete-char ed-empty) "")
(define (delete-char ed)
  (if (> (string-length (editor-content ed)) 0)
      (string-append
       (substring (editor-content ed) 0 (index-1 ed))
       (substring (editor-content ed) (editor-cursor-at ed)))
      ""))

;; Editor 1String -> String
;; Inserts a character into an editor content.
(check-expect (insert-char ed-0 "") "hi-fi")
(check-expect (insert-char ed-3 "") "hi-fi")
(check-expect (insert-char ed-5 "") "hi-fi")
(check-expect (insert-char ed-empty "") "")
(check-expect (insert-char ed-0 "a") "ahi-fi")
(check-expect (insert-char ed-3 "a") "hi-afi")
(check-expect (insert-char ed-5 "a") "hi-fia")
(check-expect (insert-char ed-empty "a") "a")
(define (insert-char ed char)
  (string-append
   (substring (editor-content ed) 0 (editor-cursor-at ed))
   char
   (substring (editor-content ed) (editor-cursor-at ed))))

;; Editor KeyEvent -> Boolean
;; Identifies if to insert a typed key into an editor.
(check-expect (insert? ed-0 "a") #true)
(check-expect (insert? ed-0 "up") #false)
(check-expect (insert? ed-0 "\t") #false)
(check-expect (insert? ed-0 "\r") #false)
(check-expect (insert? ed-200 "a") #false)
(define (insert? ed ke)
  (and (= (string-length ke) 1)
       (not (string=? ke "\t"))
       (not (string=? ke "\r"))
       (<
        (image-width (draw-text (editor-content ed)))
        (- SCENE-WIDTH 10))))


;;; Application

;(run (make-editor "" 0))

