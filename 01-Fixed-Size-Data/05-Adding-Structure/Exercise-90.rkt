;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-90) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 90.
;; Modify the happy-cat program from the preceding exercises
;; so that it stops whenever the cat’s happiness falls to 0.


(require 2htdp/universe)
(require 2htdp/image)


;;; Constants and Data Definitions

;; A Score is a Number
;; in an interval [0, 100]
;; Represents a happiness level.

(define-struct vCat [x score])
;; A VCat is a structure:
;; (make-vCat Number Score)
;; (make-vCat x s) represents a walking cat
;; which is located on an x-coordinate x and
;; has a happiness level s.

(define CAT1 (bitmap "./images/cat1.png"))
(define CAT2 (bitmap "./images/cat2.png"))
(define CAT3 (bitmap "./images/cat3.png"))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))
(define CANVAS-WIDTH (* CAT-WIDTH 6))
(define CANVAS-HEIGHT (* CAT-HEIGHT 1.5))
(define CAT-Y (- CANVAS-HEIGHT (/ CAT-HEIGHT 2)))
(define CAT-VELOCITY 3)

(define SCORE-MAX 100)
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)
(define SCORE-FEED 5) ; the 5th part of the gauge.
(define SCORE-PET 3) ; the 3rd part of the gauge.
(define GAUGE-HEIGHT 10)
(define FRAME-WIDTH SCORE-MAX)
(define FRAME-HEIGHT (+ GAUGE-HEIGHT 2))


;;; Functions

;; VCat -> VCat
;; Usage: (happy-cat (make-vCat 0 100))
(define (happy-cat cat)
  (big-bang cat
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]
    [stop-when end?]))

;; VCat -> Image
;; Produces an image of a walking cat
;; and a happiness gauge.
(define (render cat)
  (place-image
   (cond
     [(= 0 (cat-step (vCat-x cat))) CAT1]
     [(= 1 (cat-step (vCat-x cat))) CAT2]
     [(= 2 (cat-step (vCat-x cat))) CAT1]
     [(= 3 (cat-step (vCat-x cat))) CAT3])
   (vCat-x cat) CAT-Y
   (if (> (vCat-score cat) SCORE-MAX)
       (draw-gauge SCORE-MAX)
       (draw-gauge (vCat-score cat)))))

;; Number -> Number
;; Calculates current step of the cat animation
;; using a given x-coordinate.
(check-expect (cat-step 0) 0)
(check-expect (cat-step 4) 0)
(check-expect (cat-step 12) 1)
(check-expect (cat-step 24) 2)
(check-expect (cat-step 36) 3)
(check-expect (cat-step 48) 0)
(check-expect (cat-step 120) 2)
(define (cat-step x)
  (modulo (round (/ x 12)) 4))

;; Score -> Image
;; Produces a happiness gauge image.
(define (draw-gauge level)
  (overlay/align/offset
   "left" "top"
   (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "transparent")
   1 20
   (overlay/align
    "left" "middle"
    (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black")
    (rectangle level GAUGE-HEIGHT "solid" "red"))))

;; VCat -> VCat
;; Constructs VCat structure for the current world clock tick.
(check-expect (tick-handler (make-vCat 0 101)) (make-vCat 3 100))
(check-expect (tick-handler (make-vCat 0 0)) (make-vCat 3 0))
(check-expect (tick-handler (make-vCat 0 10)) (make-vCat 3 9.9))
(check-expect (tick-handler (make-vCat 50 15.5)) (make-vCat 53 15.4))
(define (tick-handler cat)
  (make-vCat
   (next (vCat-x cat))
   (cond
     [(> (vCat-score cat) SCORE-MAX) SCORE-MAX]
     [(<= (vCat-score cat) SCORE-DECREASE) 0]
     [else (- (vCat-score cat) SCORE-DECREASE)])))

;; Number -> Number
;; Calculates next x-coordinate of the walking cat position,
;; starting over from the left, whenever the cat leaves the canvas.
(check-expect (next 0) 3)
(check-expect (next 100) 103)
(define (next x)
  (modulo
   (+ CAT-VELOCITY x)
   (round (+ CANVAS-WIDTH (/ CAT-WIDTH 2)))))

;; VCat KeyEvent -> VCat
;; Increases happiness level on "down" and "up" keys presses.
(check-expect (key-handler (make-vCat 0 30) "down") (make-vCat 0 36))
(check-expect (key-handler (make-vCat 0 30) "up") (make-vCat 0 40))
(check-expect (key-handler (make-vCat 0 30) "a") (make-vCat 0 30))
(define (key-handler cat key)
  (make-vCat
   (vCat-x cat)
   (cond
     [(key=? key "down") (score+ (vCat-score cat) SCORE-FEED)]
     [(key=? key "up") (score+ (vCat-score cat) SCORE-PET)]
     [else (vCat-score cat)])))

;; Score Number -> Number
;; Increases score value by n-th part.
(check-expect (score+ SCORE-MAX 1) SCORE-MAX)
(check-expect (score+ 30 3) 40)
(define (score+ score n)
  (if (> (+ (/ score n) score) SCORE-MAX)
      SCORE-MAX
      (+ (/ score n) score)))

;; VCat -> Boolean
;; Identifies if to shut down the program.
(check-expect (end? (make-vCat 100 80)) #false)
(check-expect (end? (make-vCat 100 0)) #true)
(define (end? cat)
 (= (vCat-score cat) 0))

;;; Application

;(happy-cat (make-vCat 0 80))

