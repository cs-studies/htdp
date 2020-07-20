;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-91) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 91.
;; Extend your structure type definition
;; and data definition from exercise 88
;; to include a direction field.
;; Adjust your happy-cat program
;; so that the cat moves in the specified direction.
;; The program should move the cat in the current direction,
;; and it should turn the cat around
;; when it reaches either end of the scene.


(require 2htdp/universe)
(require 2htdp/image)


;;; Constants and Data Definitions

(define-struct walk [x delta])
;; A Walk is a structure:
;; (make-walk Number Number)
;; (make-walk x d) represents a walk, where
;; x denotes a current position at x-coordinate,
;; delta denotes a change in x-coordinate on each move.

;; A Score is a Number
;; in an interval [0, 100].
;; Represents a cat's happiness level.

(define-struct vCat [walk score])
;; A VCat is a structure:
;; (make-vCat Walk Score)
;; (make-vCat w s) represents a walking cat, where
;; w denotes a movement of a cat,
;; s denotes a happiness level of a cat.

(define CAT1 (bitmap "./images/cat1.png"))
(define CAT2 (bitmap "./images/cat2.png"))
(define CAT3 (bitmap "./images/cat3.png"))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))
(define CANVAS-WIDTH (* CAT-WIDTH 6))
(define CANVAS-HEIGHT (* CAT-HEIGHT 1.5))
(define CAT-Y (- CANVAS-HEIGHT (/ CAT-HEIGHT 2)))
(define CAT-X-MAX (- CANVAS-WIDTH (/ CAT-WIDTH 2)))
(define CAT-X-MIN (/ CAT-WIDTH 2))

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
;; Usage: (happy-cat (make-vCat (make-walk 0 3) 100))
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
   (cat-image (walk-x (vCat-walk cat)))
   (walk-x (vCat-walk cat)) CAT-Y
   (if (> (vCat-score cat) SCORE-MAX)
       (draw-gauge SCORE-MAX)
       (draw-gauge (vCat-score cat)))))

;; Number -> Image
;; Returns a particular image of a cat
;; that depends on a cat's position.
(check-expect (cat-image 12) CAT2)
(check-expect (cat-image 24) CAT1)
(check-expect (cat-image 36) CAT3)
(check-expect (cat-image 48) CAT1)
(define (cat-image x)
  (cond
    [(or (= 0 (cat-step x)) (= 2 (cat-step x))) CAT1]
    [(= 1 (cat-step x)) CAT2]
    [(= 3 (cat-step x)) CAT3]))

;; Number -> Number
;; Calculates current step of a cat animation
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
(check-expect (tick-handler (make-vCat (make-walk 100 3) 15.5))
              (make-vCat (make-walk 103 3) (- 15.5 SCORE-DECREASE)))
(check-expect (tick-handler (make-vCat (make-walk 100 -3) 15.5))
              (make-vCat (make-walk 97 -3) (- 15.5 SCORE-DECREASE)))
(define (tick-handler cat)
  (make-vCat
   (next-walk (vCat-walk cat))
   (next-score (vCat-score cat))))

;; Walk -> Walk
;; Calculates next x-coordinate of the walking cat position.
(check-expect (next-walk (make-walk 0 -3)) (make-walk CAT-X-MIN 3))
(check-expect (next-walk (make-walk 100 3)) (make-walk 103 3))
(check-expect (next-walk (make-walk 100 -3)) (make-walk 97 -3))
(check-expect (next-walk (make-walk CAT-X-MAX 3))
              (make-walk CAT-X-MAX -3))
(check-expect (next-walk (make-walk CAT-X-MAX -3))
              (make-walk (- CAT-X-MAX 3) -3))
(define (next-walk w)
  (cond
    [(>= CAT-X-MIN (x+delta w))
     (make-walk CAT-X-MIN (abs (walk-delta w)))]
    [(<= CAT-X-MAX (x+delta w))
     (make-walk CAT-X-MAX (- 0 (abs (walk-delta w))))]
    [else (make-walk (x+delta w) (walk-delta w))]))

;; Walk -> Number
;; Calculates a sum of walk-x and walk-delta.
(check-expect (x+delta (make-walk 0 3)) 3)
(check-expect (x+delta (make-walk 10 3)) 13)
(check-expect (x+delta (make-walk 1000 3)) 1003)
(check-expect (x+delta (make-walk 0 -3)) -3)
(check-expect (x+delta (make-walk 10 -3)) 7)
(check-expect (x+delta (make-walk 1000 -3)) 997)
(define (x+delta w)
  (+ (walk-x w) (walk-delta w)))

;; Score -> Score
;; Produces next score of a happiness gauge.
(check-expect (next-score 100) (- 100 SCORE-DECREASE))
(check-expect (next-score (+ SCORE-MAX 1)) SCORE-MAX)
(check-expect (next-score -1) 0)
(define (next-score score)
  (cond
    [(> score SCORE-MAX) SCORE-MAX]
    [(<= score SCORE-DECREASE) 0]
    [else (- score SCORE-DECREASE)]))

;; VCat KeyEvent -> VCat
;; Increases happiness level on "down" and "up" keys presses.
(check-expect (key-handler (make-vCat (make-walk 0 3) 30) "down")
              (make-vCat (make-walk 0 3) 36))
(check-expect (key-handler (make-vCat (make-walk 10 -3) 30) "up")
              (make-vCat (make-walk 10 -3) 40))
(check-expect (key-handler (make-vCat (make-walk 100 3) 30) "a")
              (make-vCat (make-walk 100 3) 30))
(define (key-handler cat key)
  (make-vCat
   (vCat-walk cat)
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
(check-expect (end? (make-vCat (make-walk 100 -3) 80)) #false)
(check-expect (end? (make-vCat (make-walk 100 -3) 0)) #true)
(define (end? cat)
  (= (vCat-score cat) 0))


;;; Application

;(happy-cat (make-vCat (make-walk 0 3) 100))
;(happy-cat (make-vCat (make-walk 100 -6) 80))

