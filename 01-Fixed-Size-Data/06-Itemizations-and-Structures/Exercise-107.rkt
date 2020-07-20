;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-107) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 107.
;; Design the cham-and-cat program,
;; which deals with both a virtual cat and a virtual chameleon.
;; You need a data definition for a "zoo"
;; containing both animals and functions for dealing with it.
;; Each key event applies to only one of the two animals.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; A Score is a Number
;; in an interval [0, 100]
;; Represents a happiness level.

(define-struct vCat [x score])
;; A VCat is a structure:
;; (make-vCat Number Score)
;; (make-vCat x s) represents a walking cat
;; which is located on an x-coordinate x and
;; has a happiness level s.

(define RED "red")
(define GREEN "green")
(define BLUE "blue")
;; A Color is one of:
;; - RED
;; - GREEN
;; - BLUE

(define-struct vCham [x color score])
;; A VCham is a structure:
;; (make-vCham Number Color Score)
;; (make-vCham x c s) represents a walking cham
;; which is located on an x-coordinate x,
;; has a color c, and
;; a happiness level s.

;; A VAnimal is either
;; - a VCat
;; - a VCham

(define KITTY "k")
(define LIZARD "l")
;; A Focus is one of:
;; - KITTY
;; - LIZARD

(define-struct zoo [cham cat focus])
;; A Zoo is a structure:
;;   (make-zoo VCham vCat Focus)
;; (make-zoo cham cat f) represents a structure
;; containing cham and cat animals,
;; with f storing which animal has the focus.

;; A KeyEvent is one of:
;; - "up"
;; - "down"
;; - "r"
;; - "b"
;; - "g"
;; - "k"
;; - "l"
;; Represents a pressed key that triggers
;; a change of the world state.


;;; Constants

(define CANVAS-WIDTH 700)
(define CANVAS-HEIGHT 300)

(define CAT1 (bitmap "./images/cat1.png"))
(define CAT2 (bitmap "./images/cat2.png"))
(define CAT3 (bitmap "./images/cat3.png"))
(define CAT-WIDTH (image-width CAT1))
(define CAT-HEIGHT (image-height CAT1))
(define CAT-Y (- CANVAS-HEIGHT (/ CAT-HEIGHT 2)))
(define CAT-SPEED 3)

(define CHAM1 (bitmap "./images/cham-v3-1.png"))
(define CHAM2 (bitmap "./images/cham-v3-2.png"))
(define CHAM-WIDTH (image-width CHAM1))
(define CHAM-HEIGHT (image-height CHAM1))
(define CHAM-Y (- CANVAS-HEIGHT (/ CHAM-HEIGHT 2) 1))
(define CHAM-SPEED 3)

(define SCORE-MAX 100)
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)
(define SCORE-FEED 2)
(define SCORE-PET 3)
(define GAUGE-HEIGHT 10)
(define FRAME-WIDTH SCORE-MAX)
(define FRAME-HEIGHT (+ GAUGE-HEIGHT 2))

(define INIT-ZOO (make-zoo (make-vCham 0 RED 100) (make-vCat 0 80) LIZARD))

(define TEST-CHAM (make-vCham 150 RED 100))
(define TEST-CAT (make-vCat 50 80))
(define TEST-ZOO-KITTY (make-zoo TEST-CHAM TEST-CAT KITTY))
(define TEST-ZOO-LIZARD (make-zoo TEST-CHAM TEST-CAT LIZARD))


;;; Functions

;; Zoo -> Zoo
;; Usage: (cham-and-cat INIT-ZOO)
(define (cham-and-cat zoo)
  (big-bang zoo
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]
    [stop-when end?]))


;; Zoo -> VAnimal
;; Returns a focus animal.
(check-expect (zoo-animal TEST-ZOO-LIZARD) (zoo-cham TEST-ZOO-LIZARD))
(check-expect (zoo-animal TEST-ZOO-KITTY) (zoo-cat TEST-ZOO-KITTY))
(define (zoo-animal zoo)
  (if (string=? LIZARD (zoo-focus zoo)) (zoo-cham zoo) (zoo-cat zoo)))

;; VAnimal -> Number
;; Returns x-coordinate of the animal.
(check-expect (animal-x TEST-CHAM) (vCham-x TEST-CHAM))
(check-expect (animal-x TEST-CAT) (vCat-x TEST-CAT))
(define (animal-x animal)
  (if (vCat? animal) (vCat-x animal) (vCham-x animal)))

;; VAnimal -> Number
;; Returns y-coordinate of the animal.
(check-expect (animal-y TEST-CHAM) CHAM-Y)
(check-expect (animal-y TEST-CAT) CAT-Y)
(define (animal-y animal)
  (if (vCat? animal) CAT-Y CHAM-Y))

;; VAnimal -> Score
;; Returns a gauge score of the animal.
(check-expect (animal-score TEST-CHAM) (vCham-score TEST-CHAM))
(check-expect (animal-score TEST-CAT) (vCat-score TEST-CAT))
(define (animal-score animal)
  (if (vCat? animal) (vCat-score animal) (vCham-score animal)))

;; VAnimal -> Number
;; Returns speed of the animal.
(check-expect (animal-speed TEST-CHAM) CHAM-SPEED)
(check-expect (animal-speed TEST-CAT) CAT-SPEED)
(define (animal-speed animal)
  (if (vCat? animal) CAT-SPEED CHAM-SPEED))


;; Zoo -> Image
;; Produces a scene with walking animals
;; and a happiness gauge of a focus animal.
(define (render zoo)
  (place-image
   (beside/align "bottom"
                 (animal-image (zoo-cat zoo))
                 (animal-image (zoo-cham zoo)))
   (animal-x (zoo-cham zoo)) (- (animal-y (zoo-cat zoo)) 1)
   (if (> (animal-score (zoo-animal zoo)) SCORE-MAX)
       (draw-gauge SCORE-MAX (zoo-focus zoo))
       (draw-gauge (animal-score (zoo-animal zoo)) (zoo-focus zoo)))))

;; VAnimal -> Image
;; Returns an image of a particular animal.
(define (animal-image animal)
  (if (vCat? animal)
      (animal-step-image animal)
      (overlay
       (animal-step-image animal)
       (cham-background (vCham-color animal)))))

;; Number -> Image
;; Returns a particular image of a chameleon
;; that depends on the chameleon's position.
(check-expect (animal-step-image (make-vCat 24 50)) CAT1)
(check-expect (animal-step-image (make-vCham 24 RED 50)) CHAM1)
(check-expect (animal-step-image (make-vCham 12 RED 100)) CHAM2)
(check-expect (animal-step-image (make-vCat 12 100)) CAT2)
(check-expect (animal-step-image (make-vCat 36 50)) CAT3)
(check-expect (animal-step-image (make-vCham 36 RED 100)) CHAM2)
(define (animal-step-image animal)
  (cond
    [(or (= 0 (animal-step (animal-x animal))) (= 2 (animal-step (animal-x animal))))
     (if (vCat? animal) CAT1 CHAM1)]
    [(= 1 (animal-step (animal-x animal)))
     (if (vCat? animal) CAT2 CHAM2)]
    [(= 3 (animal-step (animal-x animal)))
     (if (vCat? animal) CAT3 CHAM2)]))

;; Number -> Number
;; Calculates current step of the animation
;; using a given x-coordinate.
(check-expect (animal-step 0) 0)
(check-expect (animal-step 4) 0)
(check-expect (animal-step 12) 1)
(check-expect (animal-step 24) 2)
(check-expect (animal-step 36) 3)
(check-expect (animal-step 48) 0)
(check-expect (animal-step 120) 2)
(define (animal-step x)
  (modulo (round (/ x 12)) 4))

;; Color -> Image
;; Produces a rectangle of a specified color.
(check-expect (cham-background RED)
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" RED))
(check-expect (cham-background GREEN)
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" GREEN))
(check-expect (cham-background BLUE)
              (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" BLUE))
(define (cham-background color)
  (rectangle CHAM-WIDTH CHAM-HEIGHT "solid" color))

;; Score Focus -> Image
;; Produces a happiness gauge image of a focus animal.
(define (draw-gauge level focus)
  (overlay/align/offset
   "left" "top"
   (empty-scene CANVAS-WIDTH CANVAS-HEIGHT "transparent")
   1 20
   (beside/align
    "baseline"
    (overlay/align
     "left" "middle"
     (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black")
     (rectangle level GAUGE-HEIGHT "solid" "red"))
    (text (if (string=? focus "k") " Cat" " Chameleon") 15 "red"))))


;; Zoo -> Zoo
;; Constructs Zoo for the current world clock tick.
(check-expect (tick-handler (make-zoo (make-vCham 50 RED 101) (make-vCat 0 101) KITTY))
              (make-zoo (make-vCham 53 RED 100) (make-vCat 3 100) KITTY))
(check-expect (tick-handler (make-zoo (make-vCham 50 RED 101) (make-vCat 0 101) LIZARD))
              (make-zoo (make-vCham 53 RED 100) (make-vCat 3 100) LIZARD))
(check-expect (tick-handler (make-zoo (make-vCham 50 RED 10) (make-vCat 0 10) KITTY))
              (make-zoo (make-vCham 53 RED 9.9) (make-vCat 3 9.9) KITTY))
(check-expect (tick-handler (make-zoo (make-vCham 50 RED 10) (make-vCat 0 10) LIZARD))
              (make-zoo (make-vCham 53 RED 9.9) (make-vCat 3 9.9) LIZARD))
(define (tick-handler zoo)
  (make-zoo
   (make-vCham
    (next-x (zoo-cham zoo))
    (vCham-color (zoo-cham zoo))
    (next-score (zoo-cham zoo)))
   (make-vCat
    (next-x (zoo-cat zoo))
    (next-score (zoo-cat zoo)))
   (zoo-focus zoo)))

;; VAnimal -> Number
;; Calculates the next x-coordinate of the animal position.
;; If the animal leaves the canvas, starts over from the leftmost position.
(check-expect (next-x (make-vCat 0 100)) 3)
(check-expect (next-x (make-vCham 100 RED 100)) 103)
(define (next-x animal)
  (modulo
   (+ (animal-x animal) (animal-speed animal))
   (round
   (+ CANVAS-WIDTH CHAM-WIDTH))))

;; VAnimal -> Score
;; Returns the next score of the animal.
(check-expect (next-score (make-vCat 0 10)) 9.9)
(check-expect (next-score (make-vCat 50 15.5)) 15.4)
(check-expect (next-score (make-vCham 0 RED 101)) 100)
(check-expect (next-score (make-vCham 0 GREEN 0)) 0)
(define (next-score animal)
  (cond
    [(> (animal-score animal) SCORE-MAX) SCORE-MAX]
    [(<= (animal-score animal) SCORE-DECREASE) 0]
    [else (- (animal-score animal) SCORE-DECREASE)]))


;; Zoo KeyEvent -> Zoo
;; Changes a state of the animal on a key press as follows:
;; - "down" increases focus animal happiness level
;; - "up" increases cat's happiness level
;; - "r" changes cham's color to red
;; - "b" changes cham's color to blue
;; - "g" changes cham's color to green
;; - "k" switches focus to the cat
;; - "l" switchis focus to the lizard
(check-expect (key-handler (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) KITTY) "up")
              (make-zoo (make-vCham 0 RED 50) (make-vCat 0 (+ SCORE-PET 30)) KITTY))
(check-expect (key-handler (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) LIZARD) "up")
              (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) LIZARD))
(check-expect (key-handler (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) KITTY) "down")
              (make-zoo (make-vCham 0 RED 50) (make-vCat 0 (+ SCORE-FEED 30)) KITTY))
(check-expect (key-handler (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) LIZARD) "down")
              (make-zoo (make-vCham 0 RED (+ SCORE-FEED 50)) (make-vCat 0 30) LIZARD))
(check-expect (key-handler (make-zoo (make-vCham 0 GREEN 50) (make-vCat 0 30) KITTY) "r")
              (make-zoo (make-vCham 0 GREEN 50) (make-vCat 0 30) KITTY))
(check-expect (key-handler (make-zoo (make-vCham 0 GREEN 50) (make-vCat 0 30) LIZARD) "r")
              (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) LIZARD))
(check-expect (key-handler (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) KITTY) "g")
              (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) KITTY))
(check-expect (key-handler (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) LIZARD) "g")
              (make-zoo (make-vCham 0 GREEN 50) (make-vCat 0 30) LIZARD))
(check-expect (key-handler (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) KITTY) "b")
              (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) KITTY))
(check-expect (key-handler (make-zoo (make-vCham 0 RED 50) (make-vCat 0 30) LIZARD) "b")
              (make-zoo (make-vCham 0 BLUE 50) (make-vCat 0 30) LIZARD))
(check-expect (key-handler TEST-ZOO-KITTY "k") TEST-ZOO-KITTY)
(check-expect (key-handler TEST-ZOO-KITTY "l") TEST-ZOO-LIZARD)
(check-expect (key-handler TEST-ZOO-LIZARD "l") TEST-ZOO-LIZARD)
(check-expect (key-handler TEST-ZOO-LIZARD "k") TEST-ZOO-KITTY)
(check-expect (key-handler TEST-ZOO-LIZARD "a") TEST-ZOO-LIZARD)
(check-expect (key-handler TEST-ZOO-KITTY "a") TEST-ZOO-KITTY)
(define (key-handler zoo key)
  (cond
    [(key=? key "k") (make-zoo (zoo-cham zoo) (zoo-cat zoo) KITTY)]
    [(key=? key "l") (make-zoo (zoo-cham zoo) (zoo-cat zoo) LIZARD)]
    [(key=? key "down")
     (make-zoo
      (if (string=? LIZARD (zoo-focus zoo))
          (make-vCham
           (animal-x (zoo-cham zoo))
           (vCham-color (zoo-cham zoo))
           (score+ (animal-score (zoo-cham zoo)) SCORE-FEED))
          (zoo-cham zoo))
      (if (string=? KITTY (zoo-focus zoo))
          (make-vCat
           (animal-x (zoo-cat zoo))
           (+ (animal-score (zoo-cat zoo)) SCORE-FEED))
          (zoo-cat zoo))
      (zoo-focus zoo))]
    [(key=? key "up")
     (if (vCat? (zoo-animal zoo))
         (make-zoo
          (zoo-cham zoo)
          (make-vCat
           (animal-x (zoo-cat zoo))
           (score+ (animal-score (zoo-cat zoo)) SCORE-PET))
          (zoo-focus zoo))
         zoo)]
    [(and (vCham? (zoo-animal zoo)) (or (key=? key "r") (key=? key "g") (key=? key "b")))
     (make-zoo
      (cond
        [(key=? key "r") (cham-with-color (zoo-cham zoo) RED)]
        [(key=? key "g") (cham-with-color (zoo-cham zoo) GREEN)]
        [(key=? key "b") (cham-with-color (zoo-cham zoo) BLUE)])
      (zoo-cat zoo)
      (zoo-focus zoo))]
    [else zoo]))

;; VCham Color -> VCham
;; Sets color of a chameleon.
(check-expect (cham-with-color (make-vCham 0 RED 100) RED) (make-vCham 0 RED 100))
(check-expect (cham-with-color (make-vCham 0 GREEN 100) RED) (make-vCham 0 RED 100))
(check-expect (cham-with-color (make-vCham 0 BLUE 100) GREEN) (make-vCham 0 GREEN 100))
(check-expect (cham-with-color (make-vCham 0 RED 100) BLUE) (make-vCham 0 BLUE 100))
(define (cham-with-color cham color)
  (make-vCham (vCham-x cham) color (vCham-score cham)))

;; Score Number -> Number
;; Increases score value by n points.
(check-expect (score+ SCORE-MAX 1) SCORE-MAX)
(check-expect (score+ 30 3) 33)
(define (score+ score n)
  (if (> (+ score n) SCORE-MAX)
      SCORE-MAX
      (+ score n)))


;; Zoo -> Boolean
;; Identifies if to stop the program.
(check-expect (end? (make-zoo (make-vCham 120 RED 80) (make-vCat 100 10) LIZARD)) #false)
(check-expect (end? (make-zoo (make-vCham 120 RED 0) (make-vCat 100 10) LIZARD)) #true)
(check-expect (end? (make-zoo (make-vCham 120 RED 10) (make-vCat 100 0) LIZARD)) #true)
(define (end? zoo)
  (or (= (animal-score (zoo-cham zoo)) 0) (= (animal-score (zoo-cat zoo)) 0)))


;;; Application

;; (cham-and-cat (make-zoo (make-vCham 0 RED 100) (make-vCat 0 80) LIZARD))
(cham-and-cat INIT-ZOO)

