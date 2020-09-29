;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-525) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 525.
;; Design the three functions.


(require 2htdp/image)


(define SMALL 4) ; a size measure in terms of pixels

(define SCENE-SIZE 50)

;; Image Posn Posn Posn -> Image
;; Adds the black triangle a, b, c to scene.
(check-expect (add-triangle (empty-scene SCENE-SIZE SCENE-SIZE 'white)
                            (make-posn 20 20) (make-posn 30 30) (make-posn 10 30))
              (add-line
               (add-line
                (add-line (empty-scene SCENE-SIZE SCENE-SIZE 'white) 10 30 20 20 'black)
                30 30 10 30 'black)
               20 20 30 30 'black))
(define (add-triangle scene a b c)
  (add-line
   (add-line
    (add-line scene (posn-x c) (posn-y c) (posn-x a) (posn-y a) 'black)
    (posn-x b) (posn-y b) (posn-x c) (posn-y c) 'black)
   (posn-x a) (posn-y a) (posn-x b) (posn-y b) 'black))

;; Posn Posn Posn -> Boolean
;; Is the triangle a, b, c too small to be divided.
(check-expect (too-small? (make-posn 10 10) (make-posn 11 11) (make-posn 9 11)) #true)
(check-expect (too-small? (make-posn 20 20) (make-posn 30 30) (make-posn 10 30)) #false)
(define (too-small? a b c)
  (local ((define (distance p1 p2)
            (sqrt (+ (expt (- (posn-x p1) (posn-x p2)) 2)
                     (expt (- (posn-y p1) (posn-y p2)) 2))))
          (define (small-side? p1 p2)
            (<= (distance p1 p2) SMALL)))
    (or (small-side? a b) (small-side? b c) (small-side? c a))))

;; Posn Posn -> Posn
;; Determines the midpoint between a and b.
(check-expect (mid-point (make-posn 10 10) (make-posn 30 30)) (make-posn 20 20))
(define (mid-point a b)
  (make-posn (* 1/2 (+ (posn-x a) (posn-x b)))
             (* 1/2 (+ (posn-y a) (posn-y b)))))

