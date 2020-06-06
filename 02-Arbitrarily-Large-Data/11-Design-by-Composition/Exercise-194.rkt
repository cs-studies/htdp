;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-194) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 194.
;; Modify connect-dots so that it consumes an additional Posn
;; to which the last Posn is connected.
;; Then modify render-poly to use this new version of connect-dots.


(require 2htdp/image)


;;; Data Definitions

;; An NELoP is one of:
;; – (cons Posn '())
;; – (cons Posn NELoP)

;; A Polygon is one of:
;; – (list Posn Posn Posn)
;; – (cons Posn Polygon)


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


;; Image Polygon -> Image
;; Adds an image of p to SCENE.
(check-expect
 (render-poly SCENE triangle-p)
 (scene+line
  (scene+line
   (scene+line SCENE 20 10 20 20 "red")
   20 20 30 20 "red")
  30 20 20 10 "red"))
(check-expect
 (render-poly SCENE square-p)
 (scene+line
  (scene+line
   (scene+line
    (scene+line SCENE 10 10 20 10 "red")
    20 10 20 20 "red")
   20 20 10 20 "red")
  10 20 10 10 "red"))
(define (render-poly img p)
  (connect-dots img p (first p)))

;; Image NELoP Posn -> Image
;; Connects the Posns in p and last Posn in an image.
(check-expect (connect-dots SCENE triangle-p (make-posn 5 15))
              (scene+line
               (scene+line
                (scene+line SCENE 30 20 5 15 "red")
                20 20 30 20 "red")
               20 10 20 20 "red"))
(check-expect (connect-dots SCENE square-p (make-posn 10 10))
              (scene+line
               (scene+line
                (scene+line
                (scene+line SCENE 10 20 10 10 "red")
                 20 20 10 20 "red")
                20 10 20 20 "red")
               10 10 20 10 "red"))
(define (connect-dots img p last)
  (cond
    [(empty? (rest p)) (render-line SCENE (first p) last)]
    [else (render-line (connect-dots img (rest p) last)
                       (first p)
                       (second p))]))

;; Image Posn Posn -> Image
;; Draws a red line from Posn p to Posn q into img.
(check-expect (render-line SCENE (make-posn 20 30) (make-posn 10 40))
              (scene+line SCENE 20 30 10 40 "red"))
(define (render-line img p q)
  (scene+line
   img (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))


;;; Application

;(render-poly SCENE triangle-p)

;(render-poly SCENE square-p)

