;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-191) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 191.
;; Adapt the second example for the render-poly function to connect-dots.


(require 2htdp/image)


;;; Data Definitions

;; An NELoP is one of:
;; – (cons Posn '())
;; – (cons Posn NELoP)


;;; Constants

(define SCENE (empty-scene 50 50))

(define triangle-p
  (list
   (make-posn 20 10)
   (make-posn 20 20)
   (make-posn 30 20)))

(define square-p
  (list
   (make-posn 10 10)
   (make-posn 20 10)
   (make-posn 20 20)
   (make-posn 10 20)))


;;; Functions

;; Image NELoP -> Image
;; Connects the dots in p by rendering lines in img.
(check-expect (connect-dots SCENE triangle-p)
              (scene+line
               (scene+line SCENE 20 20 30 20 "red")
               20 10 20 20 "red"))
(check-expect (connect-dots SCENE square-p)
              (scene+line
               (scene+line
                (scene+line SCENE 20 20 10 20 "red")
                20 10 20 20 "red")
               10 10 20 10 "red"))
(define (connect-dots img p)
  (cond
    [(empty? (rest p)) img]
    [else (render-line (connect-dots img (rest p)) (first p) (second p))]))

;; Image Posn Posn -> Image
;; Renders a line from p to q into img.
(check-expect (render-line SCENE (make-posn 20 30) (make-posn 10 40))
              (scene+line SCENE 20 30 10 40 "red"))
(define (render-line img p q)
  (scene+line
   img
   (posn-x p) (posn-y p) (posn-x q) (posn-y q)
   "red"))

