;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-258) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 258.
;; Use a local expression to organize the functions
;; for drawing a polygon in figure 73.
;; If a globally defined function is widely useful, do not make it local.


(require 2htdp/image)


;; An NELoP is one of:
;; – (cons Posn '())
;; – (cons Posn NELoP)

;; A Polygon is one of:
;; – (list Posn Posn Posn)
;; – (cons Posn Polygon)


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


(check-expect
 (render-polygon SCENE triangle-p)
 (scene+line
  (scene+line
   (scene+line SCENE 20 10 20 20 "red")
   20 20 30 20 "red")
  30 20 20 10 "red"))
(check-expect
 (render-polygon SCENE square-p)
 (scene+line
  (scene+line
   (scene+line
    (scene+line SCENE 10 10 20 10 "red")
    20 10 20 20 "red")
   20 20 10 20 "red")
  10 20 10 10 "red"))


(define (render-polygon img0 p0)
  (local (
          ;; Image Polygon -> Image
          ;; Renders polygon edges.
          (define (render-lines img p)
            (render-line (connect-dots img p) (first p) (last p)))

          ;; Image NELoP -> Image
          ;; Connects the Posns in p in an image.
          ;; Does not connect the last and first Posns.
          (define (connect-dots img p)
            (cond
              [(empty? (rest p)) SCENE]
              [else (render-line (connect-dots img (rest p))
                                 (first p)
                                 (second p))]))

          ;; Polygon -> Posn
          ;; Extracts the last item from p.
          (define (last p)
            (cond
              [(empty? (rest (rest (rest p)))) (third p)]
              [else (last (rest p))])))
    (render-lines img0 p0)))


;; Image Posn Posn -> Image
;; Draws a red line from Posn p to Posn q into im.
(define (render-line im p q)
  (scene+line
   im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))

