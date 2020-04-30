;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Space-Invader) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 98.
;; Design the function si-game-over? for use as the stop-when handler.
;;
;; Exercise 99.
;; Design si-move.
;; This function is called for every clock tick
;; to determine to which position the objects move now.
;;
;; Exercise 100.
;; Design the function si-control, which plays the role of the key-event handler.
;; Once you have this function, you can define the si-main function,
;; which uses big-bang to spawn the game-playing window.
;;
;; Exercise 114.
;; Use the predicates from exercise 113 to check
;; - the space invader world program ...



(require 2htdp/universe)
(require 2htdp/image)

;;; Data Definitions

;; A UFO is a Posn.
;; (make-posn x y) is the UFO's location,
;; using the top-down, left-to-right convention.

(define-struct tank [loc vel])
;; A Tank is a structure:
;;   (make-tank Number Number).
;; (make-tank x dx) specifies the x position
;; and the tank's speed: dx pixels/tick.

;; A Missile is a Posn.
;; (make-posn x y) is the missile's position.

(define-struct aim [ufo tank])
;; An Aim is a structure:
;;     (make-aim UFO Tank)
;; Represents states getting tank in position for a shot.

(define-struct fired [ufo tank missile])
;; A Fired is a structure:
;;    (make-fired UFO Tank Missile)
;; Represents states after the missile is fired.

;; A GameState is one of:
;; – (make-aim UFO Tank)
;; – (make-fired UFO Tank Missile)
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
  (make-aim
   (make-posn UFO-X-START UFO-Y-START)
   (make-tank TANK-X-START TANK-SPEED)))


(define TEST-AIM
  (make-aim
   (make-posn 10 20)
   (make-tank 28 (- 0 TANK-SPEED))))

(define TEST-HIT
  (make-fired
   (make-posn 20 100)
   (make-tank 100 TANK-SPEED)
   (make-posn 20 103)))

(define TEST-LANDED
  (make-fired
   (make-posn 70 UFO-Y-LANDED)
   (make-tank 28 (- 0 TANK-SPEED))
   (make-posn 32 32)))


;;; Functions

;; GameState -> GameState
;; Usage: (si-main INIT-STATE)
(define (si-main gs)
  (big-bang gs
    [to-draw si-render]
    [on-tick si-move]
    [on-key si-control]
    [check-with game-state?] ; exercise 114
    [stop-when si-game-over? si-render-final]))

;; GameState -> Image
;; Adds Tank, UFO, and possibly Missile to
;; the BACKGROUND scene.
(check-expect (si-render INIT-STATE)
              (tank-render (aim-tank INIT-STATE)
                           (ufo-render (aim-ufo INIT-STATE)
                                       BACKGROUND)))
(check-expect (si-render TEST-HIT)
              (tank-render (fired-tank TEST-HIT)
                           (ufo-render (fired-ufo TEST-HIT)
                                       (missile-render (fired-missile TEST-HIT)
                                                       BACKGROUND))))
(define (si-render gs)
  (cond
    [(aim? gs)
     (tank-render (aim-tank gs)
                  (ufo-render (aim-ufo gs)
                              BACKGROUND))]
    [(fired? gs)
     (tank-render (fired-tank gs)
                  (ufo-render (fired-ufo gs)
                              (missile-render (fired-missile gs)
                                              BACKGROUND)))]))

;; Tank Image -> Image
;; Adds tank to the given image.
(check-expect (tank-render (make-tank 50 TANK-SPEED) BACKGROUND)
              (place-image TANK-IMAGE 50 TANK-Y BACKGROUND))
(define (tank-render tank img)
  (place-image TANK-IMAGE (tank-loc tank) TANK-Y img))

;; UFO Image -> Image
;; Adds ufo to the given image.
(check-expect (ufo-render (make-posn 50 50) (empty-scene 100 100 "pink"))
              (place-image UFO-IMAGE 50 50 (empty-scene 100 100 "pink")))
(define (ufo-render ufo img)
  (place-image UFO-IMAGE (posn-x ufo) (posn-y ufo) img))

;; Missile Image -> Image
;; Adds missile to the given image.
(check-expect (missile-render (make-posn 40 20) (empty-scene 100 100 "pink"))
              (place-image MISSILE-IMAGE 40 20 (empty-scene 100 100 "pink")))
(define (missile-render missile img)
  (place-image MISSILE-IMAGE (posn-x missile) (posn-y missile) img))


;; GameState -> GameState
;; Moves the game objects on each clock tick.
(define (si-move gs)
  (cond
    [(aim? gs) (make-aim (move-ufo (aim-ufo gs)) (move-tank (aim-tank gs)))]
    [(fired? gs) (make-fired
                  (move-ufo (fired-ufo gs))
                  (move-tank (fired-tank gs))
                  (move-missile (fired-missile gs)))]))

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
(define (move-missile missile)
  (make-posn (posn-x missile) (- (posn-y missile) MISSILE-SPEED)))


;; GameState KeyEvent -> GameState
;; Produces a new game state
;; when one of these keys is pressed:
;; - left [ensures the tank moves left]
;; - right [ensures the tank moves right]
;; - space [launches a missile]
(check-expect (si-control INIT-STATE "left")
              (make-aim
               (make-posn UFO-X-START UFO-Y-START)
               (make-tank TANK-X-START (- 0 TANK-SPEED))))
(check-expect (si-control TEST-HIT "left")
              (make-fired
               (fired-ufo TEST-HIT)
               (make-tank (tank-loc (fired-tank TEST-HIT)) (- 0 TANK-SPEED))
               (fired-missile TEST-HIT)))
(check-expect (si-control TEST-HIT "right") TEST-HIT)
(check-expect (si-control INIT-STATE "right") INIT-STATE)
(check-expect (si-control INIT-STATE " ")
              (make-fired
               (aim-ufo INIT-STATE)
               (aim-tank INIT-STATE)
               (make-posn (tank-loc (aim-tank INIT-STATE)) MISSILE-Y-START)))
(check-expect (si-control TEST-HIT " ") TEST-HIT)
(check-expect (si-control INIT-STATE "a") INIT-STATE)
(define (si-control gs ke)
  (cond
    [(or (string=? ke "left") (string=? ke "right"))
     (if (aim? gs)
         (make-aim
          (aim-ufo gs)
          (make-tank (tank-loc (aim-tank gs)) (tank-speed ke)))
         (make-fired
          (fired-ufo gs)
          (make-tank (tank-loc (fired-tank gs)) (tank-speed ke))
          (fired-missile gs)))]
    [(string=? ke " ")
     (if (aim? gs)
         (make-fired
          (aim-ufo gs)
          (aim-tank gs)
          (make-posn (tank-loc (aim-tank gs)) MISSILE-Y-START))
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
  (cond
    [(aim? gs) (ufo-landed? (aim-ufo gs))]
    [(fired? gs)
     (or (ufo-hit? (fired-ufo gs) (fired-missile gs))
         (ufo-landed? (fired-ufo gs)))]))


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
(check-expect (ufo-hit?  (fired-ufo TEST-HIT) (fired-missile TEST-HIT)) #true)
(check-expect (ufo-hit? (fired-ufo TEST-LANDED) (fired-missile TEST-LANDED)) #false)
(define (ufo-hit? ufo missile)
  (<= (distance ufo missile) HIT-DISTANCE))

;; Posn Posn -> PositiveNumber
;; Calculates distance between two points.
(check-expect (distance (make-posn 20 20) (make-posn 30 40)) 22)
(check-expect (distance (make-posn 20 20) (make-posn 20 22)) 2)
(define (distance p1 p2)
  (integer-sqrt
   (+
    (expt (- (posn-x p1) (posn-x p2)) 2)
    (expt (- (posn-y p1) (posn-y p2)) 2))))

;; Any -> Boolean
;; Checks that gs is an element of the GameState collection.
(check-expect (game-state? TEST-AIM) #true)
(check-expect (game-state? TEST-HIT) #true)
(check-expect (game-state? 1) #false)
(check-expect (game-state? #true) #false)
(check-expect (game-state? (make-posn 22 33)) #false)
(define (game-state? gs)
  (or (aim? gs) (fired? gs)))

;; GameState -> Image
;; Renders the last scene of the game.
(check-expect (si-render-final TEST-LANDED)
              (overlay (text "Game Over" 26 "yellow") BACKGROUND))
(check-expect (si-render-final TEST-HIT)
              (overlay (text "YOU WON" 26 "yellow") BACKGROUND))
(define (si-render-final gs)
  (overlay
   (text
    (if (ufo-landed? (if (aim? gs) (aim-ufo gs) (fired-ufo gs))) "Game Over" "YOU WON")
    26
    "yellow")
   BACKGROUND))


;;; Application
;;(si-main INIT-STATE)

