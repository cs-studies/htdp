;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-86) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 86.
;; Notice that if you type a lot,
;; your editor program does not display all of the text.
;; Instead the text is cut off at the right margin.
;; Modify your function edit from exercise 84
;; so that it ignores a keystroke
;; if adding it to the end of the pre field
;; would mean the rendered text is too wide for your canvas.


(require 2htdp/universe)
(require 2htdp/image)


;;; Constants and Data Definitions

(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor String String)
;; (make-editor s t) describes an editor
;; whose visible text is (string-append s t) with
;; the cursor displayed between s and t

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
(define ed-0 (make-editor "" "hi-fi"))
(define ed-3 (make-editor "hi-" "fi"))
(define ed-5 (make-editor "hi-fi" ""))
(define ed-200 (make-editor "" (make-string 200 #\a)))
(define ed-empty (make-editor "" ""))


;; Functions

;; Editor -> Editor
;; Launches an interactive editor.
;; Usage: (run (make-editor "hi-" "fi"))
(define (run ed)
  (big-bang ed
    [to-draw render]
    [on-key edit]))

;; Editor -> Image
;; Renders an image based on editor structure data.
(check-expect (render (make-editor "hi-" "fi"))
              (overlay/align
               "left" "center"
               (beside (draw-text "hi-") CURSOR (draw-text "fi"))
               SCENE))
(define (render ed)
  (overlay/align
   "left" "center"
   (beside (draw-text (editor-pre ed)) CURSOR (draw-text (editor-post ed)))
   SCENE))

;; String -> Image
;; Constructs an image that draws the given string.
(check-expect (draw-text "hi-fi") (text "hi-fi" TEXT-SIZE TEXT-COLOR))
(define (draw-text str)
  (text str TEXT-SIZE TEXT-COLOR))

;; Editor KeyEvent -> Editor
;; Produces an editor based on given parameters.
(check-expect (edit ed-0 "a") (make-editor "a" "hi-fi"))
(check-expect (edit ed-3 "a") (make-editor "hi-a" "fi"))
(check-expect (edit ed-5 "a") (make-editor "hi-fia" ""))
(check-expect (edit ed-empty "a") (make-editor "a" ""))
(check-expect (edit ed-200 "b") ed-200)
(check-expect (edit ed-0 " ") (make-editor " " "hi-fi"))
(check-expect (edit ed-3 " ") (make-editor "hi- " "fi"))
(check-expect (edit ed-5 " ") (make-editor "hi-fi " ""))
(check-expect (edit ed-empty " ") (make-editor " " ""))
(check-expect (edit ed-0 "\b") (make-editor "" "hi-fi"))
(check-expect (edit ed-3 "\b") (make-editor "hi" "fi"))
(check-expect (edit ed-5 "\b") (make-editor "hi-f" ""))
(check-expect (edit ed-empty "\b") ed-empty)
(check-expect (edit ed-0 "") ed-0)
(check-expect (edit ed-3 "\t") ed-3)
(check-expect (edit ed-5 "\r") ed-5)
(check-expect (edit ed-empty "") ed-empty)
(check-expect (edit ed-0 "left") ed-0)
(check-expect (edit ed-3 "left") (make-editor "hi" "-fi"))
(check-expect (edit ed-5 "left") (make-editor "hi-f" "i"))
(check-expect (edit ed-empty "") ed-empty)
(check-expect (edit ed-0 "right") (make-editor "h" "i-fi"))
(check-expect (edit ed-3 "right") (make-editor "hi-f" "i"))
(check-expect (edit ed-5 "right") ed-5)
(check-expect (edit ed-empty "") ed-empty)
(define (edit ed ke)
  (cond
    [(string=? ke "left") (make-editor
                           (string-remove-last (editor-pre ed))
                           (string-append
                            (string-last (editor-pre ed))
                            (editor-post ed)))]
    [(string=? ke "right") (make-editor
                            (string-append
                             (editor-pre ed)
                             (string-first (editor-post ed)))
                            (string-remove-first (editor-post ed)))]
    [(string=? ke "\b") (make-editor
                         (string-remove-last (editor-pre ed))
                         (editor-post ed))]
    [(insert? ed ke) (make-editor
                      (string-append (editor-pre ed) ke)
                      (editor-post ed))]
    [else ed]))

;; String -> String
;; Returns the first character of a given string.
(check-expect (string-first "Str") "S")
(check-expect (string-first "S") "S")
(check-expect (string-first "") "")
(define (string-first s)
  (if (> (string-length s) 1)
      (substring s 0 1)
      s))

;; String -> String
;; Returns a given string without the first character.
(check-expect (string-remove-first "Str") "tr")
(check-expect (string-remove-first "S") "")
(check-expect (string-remove-first "") "")
(define (string-remove-first s)
  (if (> (string-length s) 0)
      (substring s 1)
      s))

;; String -> String
;; Returns the last character of a given string.
(check-expect (string-last "Str") "r")
(check-expect (string-last "r") "r")
(check-expect (string-last "") "")
(define (string-last s)
  (if (> (string-length s) 0)
      (substring s (- (string-length s) 1))
      s))

;; String -> String
;; Returns a given string without the last character.
(check-expect (string-remove-last "Str") "St")
(check-expect (string-remove-last "r") "")
(check-expect (string-remove-last "") "")
(define (string-remove-last s)
  (if (> (string-length s) 0)
      (substring s 0 (- (string-length s) 1))
      s))

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
        (image-width (draw-text (string-append (editor-pre ed) (editor-post ed))))
        (- SCENE-WIDTH 10))))


;;; Application

;(run (make-editor "" ""))

