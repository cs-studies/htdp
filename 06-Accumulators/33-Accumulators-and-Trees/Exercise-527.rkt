;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-527) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 527.
;; Design the function add-savannah.


(require 2htdp/image)


(define SMALL 4)
(define SCENE (empty-scene 400 400 'white))

(define LEFT-BASE 0.3)
(define LEFT-LEN 0.7)
(define LEFT-DEG 12)

(define RIGHT-BASE 0.7)
(define RIGHT-LEN 0.6)
(define RIGHT-DEG 15)


;; Image N N N N -> Image
;; Adds a fractal Savannah tree to the given image.
(define (add-savannah scene0 x y len angle)
  (cond
    [(<= len SMALL) scene0]
    [else
     (local
       ((define (end-point x y len angle)
          (local ((define deg->radian (* angle (/ pi 180)))
                  (define ex (round (* len (inexact->exact (cos deg->radian)))))
                  (define ey (round (* len (inexact->exact (sin deg->radian))))))
            (make-posn (+ x ex) (- y ey))))

        (define end1 (end-point x y len angle))
        (define scene1
          (add-line scene0 x y (posn-x end1) (posn-y end1) 'red))

        (define base-left (end-point x y (* len LEFT-BASE) angle))
        (define base-right (end-point x y (* len RIGHT-BASE) angle))

        (define scene2
          (add-savannah scene1
                        (posn-x base-left) (posn-y base-left)
                        (* len LEFT-LEN) (+ angle LEFT-DEG))))

       (add-savannah scene2
                     (posn-x base-right) (posn-y base-right)
                     (* len RIGHT-LEN) (- angle RIGHT-DEG)))]))


;;; Application

(add-savannah SCENE 200 400 200 90)

