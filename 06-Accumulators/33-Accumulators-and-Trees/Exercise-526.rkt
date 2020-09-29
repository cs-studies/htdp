;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-526) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 526.
;; To compute the endpoints of an equilateral Sierpinski triangle,
;; draw a circle and pick three points on the circle
;; that are 120 degrees apart, for example, 120, 240, and 360.
;; Design the function circle-pt.


(require 2htdp/image)


;;; ADD-SIERPINSKI

(define SMALL 4) ; a size measure in terms of pixels

(define SCENE (empty-scene 400 400 'white))
(define A (make-posn 200  50))
(define B (make-posn  27 350))
(define C (make-posn 373 350))

;; Image Posn Posn Posn -> Image
;; Generative: adds the triangle (a, b, c) to s,
;; subdivides it into three triangles by taking the
;; midpoints of its sides; stop if (a, b, c) is too small.
;; Accumulator: the function accumulates the triangles scene0.
(define (add-sierpinski scene0 a b c)
  (local
    (;; Posn Posn Posn -> Boolean
     (define (too-small? a b c)
       (local ((define (distance p1 p2)
                 (sqrt (+ (expt (- (posn-x p1) (posn-x p2)) 2)
                          (expt (- (posn-y p1) (posn-y p2)) 2))))
               (define (small-side? p1 p2)
                 (<= (distance p1 p2) SMALL)))
         (or (small-side? a b) (small-side? b c) (small-side? c a)))))
    (cond
      [(too-small? a b c) scene0]
      [else
       (local
         (;; Image Posn Posn Posn -> Image
          (define (add-triangle scene a b c)
            (add-line
             (add-line
              (add-line scene (posn-x c) (posn-y c) (posn-x a) (posn-y a) 'black)
              (posn-x b) (posn-y b) (posn-x c) (posn-y c) 'black)
             (posn-x a) (posn-y a) (posn-x b) (posn-y b) 'black))
          ;; Posn Posn -> Posn
          (define (mid-point a b)
            (make-posn (* 1/2 (+ (posn-x a) (posn-x b)))
                       (* 1/2 (+ (posn-y a) (posn-y b)))))

          (define scene1 (add-triangle scene0 a b c))
          (define mid-a-b (mid-point a b))
          (define mid-b-c (mid-point b c))
          (define mid-c-a (mid-point c a))
          (define scene2 (add-sierpinski scene1 a mid-a-b mid-c-a))
          (define scene3 (add-sierpinski scene2 b mid-b-c mid-a-b)))

         (add-sierpinski scene3 c mid-c-a mid-b-c))])))


;;; Application

;(add-sierpinski SCENE A B C)


;;; CIRCLE-PT

;; See https://en.wikipedia.org/wiki/Polar_coordinate_system

(define CENTER (make-posn 200 200))
(define RADIUS 200) ; the radius in pixels

;; Number -> Posn
;; Determines the point on the circle with CENTER and RADIUS.
(check-expect (circle-pt 90/360) (make-posn 200 0))
(check-expect (circle-pt 210/360) (make-posn 27 100))
(check-expect (circle-pt 330/360) (make-posn 373 100))
(check-expect (circle-pt 360/360) (make-posn 400 200))
(define (circle-pt factor)
  (local ((define offset-x (posn-x CENTER))
          (define offset-y (posn-y CENTER))
          (define (factor->radian f)
            (* f 360 (/ pi 180)))
          (define x (round (* RADIUS (inexact->exact (cos (factor->radian factor))))))
          (define y (round (* RADIUS (inexact->exact (sin (factor->radian factor)))))))
    (make-posn (+ x offset-x)
               (if (< y 0) (+ offset-y y) (- offset-y y)))))

