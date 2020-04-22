;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-102) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 102.
;; Design all other functions that are needed to complete the game for this second data definition.


(require 2htdp/image)
(require 2htdp/universe)


;;; Data Definitions

;; A UFO is a Posn.
;; (make-posn x y) is the UFO's location,
;; using the top-down, left-to-right convention.

(define-struct tank [loc vel])
;; A Tank is a structure:
;;   (make-tank Number Number).
;; (make-tank x dx) specifies the x position
;; and the tank's speed: dx pixels/tick.

;; A MissileOrNot is one of:
;; – #false
;; – Posn
;; #false means the missile is in the tank;
;; Posn says the missile is at that location.

(define-struct gs [ufo tank missile])
;; A GS (short for Game State) is a structure:
;;   (make-gs UFO Tank MissileOrNot)
;; Represents the complete state of a
;; space invader game.

;; A KeyEventMove is one of:
;; - "left"
;; - "right"
;; Represents a pressed key that sets
;; a movement direction of the tank.

;; A KeyEvent is one of:
;; - KeyEventMove
;; - " "
;; Represents a pressed key that triggers
;; a game state change.


;;; Constants

(define WIDTH 200)
(define HEIGHT 400)
(define BACKGROUND (empty-scene WIDTH HEIGHT "deepskyblue"))

(define UFO-HEIGHT 20)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO-IMAGE (overlay
                   (circle (/ UFO-HEIGHT 2) "solid" "palegreen")
                   (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "green")))
(define UFO-X-START (/ WIDTH 2))
(define UFO-X-MIN (/ UFO-WIDTH 2))
(define UFO-X-MAX (- WIDTH (/ UFO-WIDTH 2)))
(define UFO-Y-START (/ UFO-HEIGHT 2))
(define UFO-Y-LANDED (- HEIGHT (/ UFO-HEIGHT 2)))
(define UFO-SPEED 3)
(define UFO-JUMP-MAX 10)

(define TANK-HEIGHT 10)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK-X-START (/ TANK-WIDTH 2))
(define TANK-X-MIN (/ TANK-WIDTH 2))
(define TANK-X-MAX (- WIDTH (/ TANK-WIDTH 2)))
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))
(define TANK-IMAGE (rectangle TANK-WIDTH TANK-HEIGHT "solid" "midnightblue"))
(define TANK-SPEED 3)

(define MISSILE-IMAGE (triangle 5 "solid" "black"))
(define MISSILE-Y-START (+ TANK-Y (/ TANK-HEIGHT 2)))
(define MISSILE-SPEED (* UFO-SPEED 2))

(define HIT-DISTANCE 20) ; pixels between UFO and Missile centers.


(define INIT-STATE
  (make-gs
   (make-posn UFO-X-START UFO-Y-START)
   (make-tank TANK-X-START TANK-SPEED)
   #false))


;;; Tests Data

(define TEST-AIM
  (make-gs
   (make-posn 10 20)
   (make-tank 28 (- 0 TANK-SPEED))
   #false))

(define TEST-HIT
  (make-gs
   (make-posn 20 100)
   (make-tank 100 TANK-SPEED)
   (make-posn 20 103)))

(define TEST-LANDED
  (make-gs
   (make-posn 70 UFO-Y-LANDED)
   (make-tank 28 (- 0 TANK-SPEED))
   (make-posn 32 32)))


;;; Functions

;; GS -> GS
;; Usage: (si-main INIT-STATE)
(define (si-main gs)
  (big-bang gs
    [to-draw si-render]
    [on-tick si-move]
    [on-key si-control]
    [stop-when si-game-over? si-render-final]))


;; GS -> Image
;; Renders the given game state on top of BACKGROUND.
(check-expect (si-render INIT-STATE)
              (tank-render (gs-tank INIT-STATE)
                           (ufo-render (gs-ufo INIT-STATE)
                                       (missile-render (gs-missile TEST-HIT)
                                                       BACKGROUND))))
(check-expect (si-render TEST-HIT)
              (tank-render (gs-tank TEST-HIT)
                           (ufo-render (gs-ufo TEST-HIT)
                                       (missile-render (gs-missile TEST-HIT)
                                                       BACKGROUND))))
(define (si-render gs)
  (tank-render
   (gs-tank gs)
   (ufo-render (gs-ufo gs)
               (missile-render (gs-missile gs)
                               BACKGROUND))))

;; Tank Image -> Image
;; Adds tank to the given image.
(check-expect (tank-render (make-tank 50 TANK-SPEED) BACKGROUND)
             (place-image TANK-IMAGE 50 TANK-Y BACKGROUND))
(define (tank-render tank scene)
  (place-image TANK-IMAGE (tank-loc tank) TANK-Y scene))

;; UFO Image -> Image
;; Adds ufo to the given image.
(check-expect (ufo-render (make-posn 50 50) (empty-scene 100 100 "pink"))
              (place-image UFO-IMAGE 50 50 (empty-scene 100 100 "pink")))
(define (ufo-render ufo scene)
  (place-image UFO-IMAGE (posn-x ufo) (posn-y ufo) scene))

;; MissileOrNot Image -> Image
;; Adds an image of a missile to the scene.
(define TEST-MISSILE (make-posn 32 (- HEIGHT TANK-HEIGHT 4)))
(check-expect (missile-render #false BACKGROUND) BACKGROUND)
(check-expect (missile-render TEST-MISSILE BACKGROUND)
              (place-image MISSILE-IMAGE (posn-x TEST-MISSILE) (posn-y TEST-MISSILE) BACKGROUND))
(define (missile-render missile scene)
  (if (boolean? missile)
      BACKGROUND
      (place-image MISSILE-IMAGE (posn-x missile) (posn-y missile) scene)))


;; GameState -> GameState
;; Moves the game objects on each clock tick.
(define (si-move gs)
  (make-gs
   (move-ufo (gs-ufo gs))
   (move-tank (gs-tank gs))
   (move-missile (gs-missile gs))))

;; UFO -> UFO
;; Calculates the next position of the UFO.
(define (move-ufo ufo)
  (make-posn
   (random-ufo-x (safe-ufo-x (posn-x ufo)))
   (+ (posn-y ufo) UFO-SPEED)))

;; Number -> Number
;; Randomly selects new x position of the UFO.
(check-range (random-ufo-x 100) (- 100 UFO-JUMP-MAX) (+ 100 UFO-JUMP-MAX))
(define (random-ufo-x x)
  (+ x
     (if (= 1 (random 2))
         (random UFO-JUMP-MAX)
         (- 0 (random UFO-JUMP-MAX)))))

;; Number -> Number
;; Limits UFO x position to prevent jumping over the scene edges.
(check-expect (safe-ufo-x 5) (+ 5 UFO-JUMP-MAX))
(check-expect (safe-ufo-x UFO-X-MAX) (- UFO-X-MAX UFO-JUMP-MAX))
(check-expect (safe-ufo-x UFO-X-START) UFO-X-START)
(define (safe-ufo-x x)
  (cond
    [(>= (+ x UFO-JUMP-MAX) UFO-X-MAX) (- x UFO-JUMP-MAX)]
    [(<= (- x UFO-JUMP-MAX) UFO-X-MIN) (+ x UFO-JUMP-MAX)]
    [else x]))

;; Tank -> Tank
;; Returns the next position of the Tank.
(check-expect (move-tank (make-tank 100 TANK-SPEED)) (make-tank (+ 100 TANK-SPEED) TANK-SPEED))
(check-expect (move-tank (make-tank 5 (- 0 TANK-SPEED))) (make-tank TANK-X-MIN TANK-SPEED))
(check-expect (move-tank (make-tank WIDTH TANK-SPEED)) (make-tank TANK-X-MAX (- 0 TANK-SPEED)))
(define (move-tank tank)
  (cond
    [(and (< (tank-vel tank) 0) (<= (tank-loc tank) TANK-X-MIN))
     (make-tank TANK-X-MIN TANK-SPEED)]
    [(and (> (tank-vel tank) 0) (>= (tank-loc tank) TANK-X-MAX))
     (make-tank TANK-X-MAX (- 0 TANK-SPEED))]
    [else
     (make-tank (+ (tank-loc tank) (tank-vel tank)) (tank-vel tank))]))

;; Missile -> Missile
;; Returns the next position of the Missile.
(check-expect (move-missile (make-posn 20 30)) (make-posn 20 (- 30 MISSILE-SPEED)))
(check-expect (move-missile #false) #false)
(define (move-missile missile)
  (if (boolean? missile)
      #false
      (make-posn (posn-x missile) (- (posn-y missile) MISSILE-SPEED))))


;; GameState KeyEvent -> GameState
;; Produces a new game state
;; when one of these keys is pressed:
;; - left [ensures the tank moves left]
;; - right [ensures the tank moves right]
;; - space [launches a missile]
(check-expect (si-control INIT-STATE "left")
              (make-gs
               (make-posn UFO-X-START UFO-Y-START)
               (make-tank TANK-X-START (- 0 TANK-SPEED))
               #false))
(check-expect (si-control TEST-HIT "left")
              (make-gs
               (gs-ufo TEST-HIT)
               (make-tank (tank-loc (gs-tank TEST-HIT)) (- 0 TANK-SPEED))
               (gs-missile TEST-HIT)))
(check-expect (si-control TEST-HIT "right") TEST-HIT)
(check-expect (si-control INIT-STATE "right") INIT-STATE)
(check-expect (si-control INIT-STATE " ")
              (make-gs
               (gs-ufo INIT-STATE)
               (gs-tank INIT-STATE)
               (make-posn (tank-loc (gs-tank INIT-STATE)) MISSILE-Y-START)))
(check-expect (si-control TEST-HIT " ") TEST-HIT)
(check-expect (si-control INIT-STATE "a") INIT-STATE)
(define (si-control gs ke)
  (cond
    [(or (string=? ke "left") (string=? ke "right"))
     (make-gs
      (gs-ufo gs)
      (make-tank (tank-loc (gs-tank gs)) (tank-speed ke))
      (gs-missile gs))]
    [(string=? ke " ")
     (if (boolean? (gs-missile gs))
         (make-gs
          (gs-ufo gs)
          (gs-tank gs)
          (make-posn (tank-loc (gs-tank gs)) MISSILE-Y-START))
         gs)]
    [else gs]))

;; KeyEventMove -> Number
;; Returns tank speed.
(check-expect (tank-speed "left") (- 0 TANK-SPEED))
(check-expect (tank-speed "right") TANK-SPEED)
(check-error (tank-speed "a") "Not supported key event")
(define (tank-speed ke)
  (cond
    [(string=? ke "left") (- 0 TANK-SPEED)]
    [(string=? ke "right") TANK-SPEED]
    [else (error "Not supported key event")]))

;; GameState -> Boolean
;; Identifies if the game is over due to one of the following:
;; - the UFO landed
;; - Missile hit the UFO
(check-expect (si-game-over? TEST-AIM) #false)
(check-expect (si-game-over? TEST-HIT) #true)
(check-expect (si-game-over? TEST-LANDED) #true)
(define (si-game-over? gs)
  (or
   (ufo-hit? (gs-ufo gs) (gs-missile gs))
   (ufo-landed? (gs-ufo gs))))


;; UFO -> Boolean
;; Checks if the UFO reached the bottom line of the scene.
(check-expect (ufo-landed? (make-posn 20 (- UFO-Y-LANDED 10))) #false)
(check-expect (ufo-landed? (make-posn 20 (- UFO-Y-LANDED 1))) #false)
(check-expect (ufo-landed? (make-posn 20 UFO-Y-LANDED)) #true)
(check-expect (ufo-landed? (make-posn 20 (+ UFO-Y-LANDED 1))) #true)
(define (ufo-landed? ufo)
  (>= (posn-y ufo) UFO-Y-LANDED))

;; UFO Missile -> Boolean
;; Checks if a Missile hit the UFO.
(check-expect (ufo-hit? (gs-ufo TEST-HIT) (gs-missile TEST-HIT)) #true)
(check-expect (ufo-hit? (gs-ufo TEST-LANDED) (gs-missile TEST-LANDED)) #false)
(check-expect (ufo-hit? (gs-ufo TEST-LANDED) #false) #false)
(define (ufo-hit? ufo missile)
  (if (boolean? missile)
      #false
      (<= (distance ufo missile) HIT-DISTANCE)))

;; Posn Posn -> PositiveNumber
;; Calculates distance between two points.
(check-expect (distance (make-posn 20 20) (make-posn 30 40)) 22)
(check-expect (distance (make-posn 20 20) (make-posn 20 22)) 2)
(define (distance p1 p2)
  (integer-sqrt
   (+
    (expt (- (posn-x p1) (posn-x p2)) 2)
    (expt (- (posn-y p1) (posn-y p2)) 2))))

;; GameState -> Image
;; Renders the last scene of the game.
(check-expect (si-render-final TEST-LANDED)
              (overlay (text "Game Over" 26 "yellow") BACKGROUND))
(check-expect (si-render-final TEST-HIT)
              (overlay (text "YOU WON" 26 "yellow") BACKGROUND))
(define (si-render-final gs)
  (overlay
   (text
    (if (ufo-landed? (gs-ufo gs)) "Game Over" "YOU WON")
    26
    "yellow")
   BACKGROUND))


;;; Application

;; (si-main INIT-STATE)

