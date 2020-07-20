;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-93) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 93.
;; Modify the exercise 92 so that
;; the chameleon walks across a tricolor background.


(require 2htdp/universe)
(require 2htdp/image)


;;; Constants and Data Definitions

;; A Score is a Number
;; in an interval [0, 100]
;; Represents a happiness level.

(define-struct vCham [x score])
;; A VCham is a structure:
;; (make-vCham Number Color Score)
;; (make-vCham x c s) represents a walking cham
;; which is located on an x-coordinate x and
;; has a happiness level s.

(define CHAM1 (bitmap "./images/cham-v2-1.png"))
(define CHAM2 (bitmap "./images/cham-v2-2.png"))
(define CHAM3 (bitmap "./images/cham-v2-1.png"))
(define CHAM-WIDTH (image-width CHAM1))
(define CHAM-HEIGHT (image-height CHAM1))
(define CANVAS-WIDTH (* CHAM-WIDTH 6))
(define CANVAS-HEIGHT (* CHAM-HEIGHT 3))
(define CHAM-Y (- CANVAS-HEIGHT (/ CHAM-HEIGHT 2) 1))
(define CHAM-VELOCITY 3)

(define SCORE-MAX 100)
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)
(define SCORE-FEED 2)
(define GAUGE-HEIGHT 10)
(define FRAME-WIDTH SCORE-MAX)
(define FRAME-HEIGHT (+ GAUGE-HEIGHT 2))

(define BG-WIDTH (/ CANVAS-WIDTH 3))
(define BG
  (beside (empty-scene BG-WIDTH CANVAS-HEIGHT "green")
          (empty-scene BG-WIDTH CANVAS-HEIGHT "blue")
          (empty-scene BG-WIDTH CANVAS-HEIGHT "red")))


;;; Functions

;; VCham -> VCham
;; Usage: (cham (make-vCham 0 100))
(define (cham cham)
  (big-bang cham
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]
    [stop-when end?]))

;; VCham -> Image
;; Produces an image of a walking cham
;; and a happiness gauge.
(define (render cham)
  (place-image
   (cham-image (vCham-x cham))
   (vCham-x cham) CHAM-Y
   (if (> (vCham-score cham) SCORE-MAX)
       (draw-gauge SCORE-MAX)
       (draw-gauge (vCham-score cham)))))

;; Number Color -> Image
;; Returns a particular image of a chameleon
;; that depends on the chameleon's position.
(check-expect (cham-image 12) CHAM2)
(check-expect (cham-image 24) CHAM1)
(check-expect (cham-image 36) CHAM3)
(check-expect (cham-image 48) CHAM1)
(define (cham-image x)
  (cond
    [(or (= 0 (cham-step x)) (= 2 (cham-step x))) CHAM1]
    [(= 1 (cham-step x)) CHAM2]
    [(= 3 (cham-step x)) CHAM3]))

;; Number -> Number
;; Calculates current step of the cham animation
;; using a given x-coordinate.
(check-expect (cham-step 0) 0)
(check-expect (cham-step 4) 0)
(check-expect (cham-step 12) 1)
(check-expect (cham-step 24) 2)
(check-expect (cham-step 36) 3)
(check-expect (cham-step 48) 0)
(check-expect (cham-step 120) 2)
(define (cham-step x)
  (modulo (round (/ x 12)) 4))

;; Score -> Image
;; Produces a happiness gauge image.
(define (draw-gauge level)
  (underlay/align/offset
   "left" "top"
   BG
   1 20
   (overlay/align
    "left" "middle"
    (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black")
    (rectangle level GAUGE-HEIGHT "solid" "red"))))

;; VCham -> VCham
;; Constructs VCham structure for the current world clock tick.
(check-expect (tick-handler (make-vCham 0 101)) (make-vCham 3 100))
(check-expect (tick-handler (make-vCham 0 0)) (make-vCham 3 0))
(check-expect (tick-handler (make-vCham 0 10)) (make-vCham 3 9.9))
(check-expect (tick-handler (make-vCham 50 15.5)) (make-vCham 53 15.4))
(define (tick-handler cham)
  (make-vCham
   (next (vCham-x cham))
   (cond
     [(> (vCham-score cham) SCORE-MAX) SCORE-MAX]
     [(<= (vCham-score cham) SCORE-DECREASE) 0]
     [else (- (vCham-score cham) SCORE-DECREASE)])))

;; Number -> Number
;; Calculates next x-coordinate of the walking cham position,
;; starting over from the left, whenever the cham leaves the canvas.
(check-expect (next 0) 3)
(check-expect (next 100) 103)
(define (next x)
  (modulo
   (+ CHAM-VELOCITY x)
   (round (+ CANVAS-WIDTH (/ CHAM-WIDTH 2)))))

;; VCham KeyEvent -> VCham
;; Increases happiness level.
(check-expect (key-handler (make-vCham 0 30) "down")
              (make-vCham 0 (+ 30 SCORE-FEED)))
(check-expect (key-handler (make-vCham 0 30) "a")
              (make-vCham 0 30))
(define (key-handler cham key)
  (make-vCham
   (vCham-x cham)
   (cond
     [(key=? key "down") (score+ (vCham-score cham) SCORE-FEED)]
     [else (vCham-score cham)])))

;; Score Number -> Number
;; Increases score value by n points.
(check-expect (score+ SCORE-MAX 1) SCORE-MAX)
(check-expect (score+ 30 3) 33)
(define (score+ score n)
  (if (> (+ score n) SCORE-MAX)
      SCORE-MAX
      (+ score n)))

;; VCham -> Boolean
;; Identifies if to shut down the program.
(check-expect (end? (make-vCham 100 80)) #false)
(check-expect (end? (make-vCham 100 0)) #true)
(define (end? cham)
  (= (vCham-score cham) 0))

;;; Application

;(cham (make-vCham 0 100))

