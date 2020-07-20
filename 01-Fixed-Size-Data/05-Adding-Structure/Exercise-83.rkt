;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-83) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 83.
;; Design the function render,
;; which consumes an Editor and produces an image.


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


;;; Functions

;; Editor -> Image
;; Renders an image based on editor structure data.
(check-expect (render (make-editor "Claude " "Shannon"))
              (overlay/align
               "left" "center"
               (beside (draw-text "Claude ") CURSOR (draw-text "Shannon"))
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


;;; Application

;(render (make-editor "Claude" "Shannon"))

