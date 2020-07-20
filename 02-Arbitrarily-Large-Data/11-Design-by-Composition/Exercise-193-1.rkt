;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-193-1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 193.
;; render-poly could cons the last item of p onto p and then call connect-dots.


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
  ;(render-line (connect-dots img p) (first p) (last p)))
  (connect-dots img (cons (last p) p)))

;; Image NELoP -> Image
;; Connects the Posns in p in an image.
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
    [(empty? (rest p)) SCENE]
    [else (render-line (connect-dots img (rest p))
                       (first p)
                       (second p))]))

;; Image Posn Posn -> Image
;; Draws a red line from Posn p to Posn q into img.
(check-expect (render-line SCENE (make-posn 20 30) (make-posn 10 40))
              (scene+line SCENE 20 30 10 40 "red"))
(define (render-line img p q)
  (scene+line
   img (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))


;; Polygon -> Posn
;; Extracts the last item from p.
(check-expect (last triangle-p) (make-posn 30 20))
(check-expect (last square-p) (make-posn 10 20))
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))


;;; Application

;(render-poly SCENE triangle-p)

;(render-poly SCENE square-p)

