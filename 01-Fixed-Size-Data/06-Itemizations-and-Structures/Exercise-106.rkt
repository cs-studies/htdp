;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-106) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 106.
;; Design the cat-cham world program.
;; Given both a location and an animal,
;; it walks the latter across the canvas, starting from the given location.
;; It remains impossible to change the color of a cat or to pet a chameleon.
;;
;; Exercise 114.
;; Use the predicates from exercise 113 to check
;; ... the virtual pet program (exercise 106) ...


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

;; A KeyEvent is one of:
;; - "up"
;; - "down"
;; - "r"
;; - "b"
;; - "g"
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


;;; Functions

;; VAnimal -> VAnimal
;; Usage:
;; - (cat-cham (make-vCat 0 100))
;; - (cat-cham (make-vCham 0 RED 100))
(define (cat-cham animal)
  (big-bang animal
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]
    [check-with vAnimal?] ; exercise 114
    [stop-when end?]))


;; VAnimal -> Number
;; Returns x-coordinate of the animal.
(check-expect (animal-x (make-vCat 50 100)) 50)
(check-expect (animal-x (make-vCham 150 RED 100)) 150)
(define (animal-x animal)
  (if (vCat? animal) (vCat-x animal) (vCham-x animal)))

;; VAnimal -> Number
;; Returns the maximal x-coordinate of the animal.
(check-expect (animal-x-max (make-vCat 50 100)) (round (+ CANVAS-WIDTH (/ CAT-WIDTH 2))))
(check-expect (animal-x-max (make-vCham 50 RED 100)) (round (+ CANVAS-WIDTH (/ CHAM-WIDTH 2))))
(define (animal-x-max animal)
  (round
   (+ CANVAS-WIDTH (/ (if (vCat? animal) CAT-WIDTH CHAM-WIDTH) 2))))

;; VAnimal -> Number
;; Returns y-coordinate of the animal.
(check-expect (animal-y (make-vCat 50 100)) CAT-Y)
(check-expect (animal-y (make-vCham 50 RED 100)) CHAM-Y)
(define (animal-y animal)
  (if (vCat? animal) CAT-Y CHAM-Y))

;; VAnimal -> Score
;; Returns a gauge score of the animal.
(check-expect (animal-score (make-vCat 50 100)) 100)
(check-expect (animal-score (make-vCham 100 RED 10)) 10)
(define (animal-score animal)
  (if (vCat? animal) (vCat-score animal) (vCham-score animal)))

;; VAnimal -> Number
;; Returns speed of the animal.
(check-expect (animal-speed (make-vCat 50 100)) CAT-SPEED)
(check-expect (animal-speed (make-vCham 50 RED 100)) CHAM-SPEED)
(define (animal-speed animal)
  (if (vCat? animal) CAT-SPEED CHAM-SPEED))


;; VAnimal -> Image
;; Produces a scene with a walking animal
;; and a happiness gauge.
(define (render animal)
  (place-image
   (animal-image animal)
   (animal-x animal) (animal-y animal)
   (if (> (animal-score animal) SCORE-MAX)
       (draw-gauge SCORE-MAX)
       (draw-gauge (animal-score animal)))))

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


;; VAnimal -> VAnimal
;; Constructs VAnimal for the current world clock tick.
(check-expect (tick-handler (make-vCat 0 101)) (make-vCat 3 100))
(check-expect (tick-handler (make-vCat 0 0)) (make-vCat 3 0))
(check-expect (tick-handler (make-vCat 0 10)) (make-vCat 3 9.9))
(check-expect (tick-handler (make-vCat 50 15.5)) (make-vCat 53 15.4))
(check-expect (tick-handler (make-vCham 0 RED 101)) (make-vCham 3 RED 100))
(check-expect (tick-handler (make-vCham 0 GREEN 0)) (make-vCham 3 GREEN 0))
(check-expect (tick-handler (make-vCham 0 BLUE 10)) (make-vCham 3 BLUE 9.9))
(check-expect (tick-handler (make-vCham 50 RED 15.5)) (make-vCham 53 RED 15.4))
(define (tick-handler animal)
  (if (vCat? animal)
      (make-vCat
       (next-x animal)
       (next-score animal))
      (make-vCham
       (next-x animal)
       (vCham-color animal)
       (next-score animal))))

;; VAnimal -> Number
;; Calculates the next x-coordinate of the animal position.
;; If the animal leaves the canvas, starts over from the leftmost position.
(check-expect (next-x (make-vCat 0 100)) 3)
(check-expect (next-x (make-vCham 100 RED 100)) 103)
(define (next-x animal)
  (modulo
   (+ (animal-x animal) (animal-speed animal))
   (animal-x-max animal)))

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


;; VAnimal KeyEvent -> VAnimal
;; Changes a state of the animal on a key press as follows:
;; - "down" increases happiness level,
;; - "up" increases vCat's happiness level,
;; - "r" changes vCham's color to red,
;; - "b" changes vCham's color to blue,
;; - "g" changes vCham's color to green.
(check-expect (key-handler (make-vCat 0 30) "up") (make-vCat 0 (+ SCORE-PET 30)))
(check-expect (key-handler (make-vCat 0 30) "down") (make-vCat 0 (+ SCORE-FEED 30)))
(check-expect (key-handler (make-vCat 0 30) "r") (make-vCat 0 30))
(check-expect (key-handler (make-vCat 0 30) "g") (make-vCat 0 30))
(check-expect (key-handler (make-vCat 0 30) "b") (make-vCat 0 30))
(check-expect (key-handler (make-vCat 0 30) "a") (make-vCat 0 30))
(check-expect (key-handler (make-vCham 0 RED 30) "up") (make-vCham 0 RED 30))
(check-expect (key-handler (make-vCham 0 RED 30) "down") (make-vCham 0 RED (+ 30 SCORE-FEED)))
(check-expect (key-handler (make-vCham 0 RED 30) "g") (make-vCham 0 GREEN 30))
(check-expect (key-handler (make-vCham 0 GREEN 30) "b") (make-vCham 0 BLUE 30))
(check-expect (key-handler (make-vCham 0 BLUE 30) "r") (make-vCham 0 RED 30))
(check-expect (key-handler (make-vCham 0 GREEN 30) "a") (make-vCham 0 GREEN 30))
(define (key-handler animal key)
  (if (vCat? animal)
  (make-vCat
   (animal-x animal)
   (cond
     [(key=? key "down") (score+ (animal-score animal) SCORE-FEED)]
     [(key=? key "up") (score+ (animal-score animal) SCORE-PET)]
     [else (animal-score animal)]))
  (make-vCham
   (animal-x animal)
   (cond
     [(key=? key "r") RED]
     [(key=? key "g") GREEN]
     [(key=? key "b") BLUE]
     [else (vCham-color animal)])
   (cond
     [(key=? key "down") (score+ (animal-score animal) SCORE-FEED)]
     [else (animal-score animal)]))))

;; Score Number -> Number
;; Increases score value by n points.
(check-expect (score+ SCORE-MAX 1) SCORE-MAX)
(check-expect (score+ 30 3) 33)
(define (score+ score n)
  (if (> (+ score n) SCORE-MAX)
      SCORE-MAX
      (+ score n)))

;; Any -> Boolean
;; Check that animal is an element of the VAnimal collection.
(check-expect (vAnimal? (make-vCat 300 60)) #true)
(check-expect (vAnimal? (make-vCham 200 "blue" 77)) #true)
(check-expect (vAnimal? 1) #false)
(check-expect (vAnimal? "a") #false)
(check-expect (vAnimal? (make-posn 2 3)) #false)
(define (vAnimal? animal)
  (or (vCat? animal) (vCham? animal)))

;; VAnimal -> Boolean
;; Identifies if to stop the program.
(check-expect (end? (make-vCat 100 80)) #false)
(check-expect (end? (make-vCat 100 0)) #true)
(check-expect (end? (make-vCham 100 RED 80)) #false)
(check-expect (end? (make-vCham 100 RED 0)) #true)
(define (end? animal)
  (= (animal-score animal) 0))


;;; Application

;; (cat-cham (make-vCat 0 80))
;; (cat-cham (make-vCham 0 RED 80))

