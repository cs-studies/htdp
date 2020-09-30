;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-528) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 528.
;; Design an algorithm that connects two points with a smooth curve.


(require 2htdp/image)


(define SMALL 15) ; a size measure in terms of pixels

(define SCENE (empty-scene 400 400 'white))
(define A (make-posn 200  50))
(define B (make-posn  50 350))
(define C (make-posn 300 200))

;; Image Posn Posn Posn -> Image
;; Generative: adds the triangle (a, b, c) to s,
;; takes midpoints of (a, b) and (c, b), then midpoint of [(a,b),(c,b)]
;; stop if (a, b, c) is too small.
;; Accumulator: the function accumulates the triangles scene0.
(define (add-curve-bezier scene0 a b c)
  (local
    (;; Posn Posn Posn -> Boolean
     (define (too-small? a b c)
       (local ((define (distance p1 p2)
                 (sqrt (+ (expt (- (posn-x p1) (posn-x p2)) 2)
                          (expt (- (posn-y p1) (posn-y p2)) 2)))))
         (< (distance a c) SMALL)))
     ;; Image Posn Posn Posn -> Image
     (define (add-triangle scene a b c)
       (add-line
        (add-line
         (add-line scene (posn-x c) (posn-y c) (posn-x a) (posn-y a) 'red)
         (posn-x b) (posn-y b) (posn-x c) (posn-y c) 'red)
        (posn-x a) (posn-y a) (posn-x b) (posn-y b) 'red))
     ;; Posn Posn -> Posn
     (define (mid-point p1 p2)
       (make-posn (* 1/2 (+ (posn-x p1) (posn-x p2)))
                  (* 1/2 (+ (posn-y p1) (posn-y p2))))))
    (cond
      [(too-small? a b c) (add-triangle scene0 a b c)]
      [else
       (local
         ((define mid-a-b (mid-point a b))
          (define mid-b-c (mid-point b c))
          (define mid-a-b-c (mid-point mid-a-b mid-b-c)))

         (add-curve-bezier (add-curve-bezier scene0 a mid-a-b mid-a-b-c)
                           c mid-b-c mid-a-b-c))])))


;;; Application

(add-curve-bezier SCENE A B C)

