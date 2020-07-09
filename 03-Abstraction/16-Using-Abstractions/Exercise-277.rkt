;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-277) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 277.
;; Apply abstractions to the exercise 224 (Full Space War).


(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; A Missiles is a one of:
;; - '()
;; - (cons Posn Missiles)

(define-struct ufo [x y missiles])
;; A UFO is a structure.
;;    (make-ufo Number Number Missiles)
;; (make-posn x y m) is the UFO's
;; location x and y coordinates
;; and the list of the missiles launched by the UFO.

(define-struct tank [x vel missiles])
;; A Tank is a structure:
;;   (make-tank Number Number Missiles).
;; (make-tank x dx Missiles) specifies the x position,
;; the tank's speed: dx pixels/tick,
;; and the list of the missiles launched by the tank.

(define-struct game [ufo tank])
;; A GameState is a structure:
;;     (make-game UFO Tank)

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

(define WIDTH 300)
(define HEIGHT 600)
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
(define UFO-SPEED 2)
(define UFO-JUMP-MAX 22)

(define TANK-HEIGHT 10)
(define TANK-WIDTH (* 2 TANK-HEIGHT))
(define TANK-X-START (/ TANK-WIDTH 2))
(define TANK-X-MIN (/ TANK-WIDTH 2))
(define TANK-X-MAX (- WIDTH (/ TANK-WIDTH 2)))
(define TANK-Y (- HEIGHT (/ TANK-HEIGHT 2)))
(define TANK-IMAGE (rectangle TANK-WIDTH TANK-HEIGHT "solid" "midnightblue"))
(define TANK-SPEED 3)

(define TANK-MISSILE (triangle 5 "solid" "black"))
(define TANK-MISSILE-Y-START (- TANK-Y (/ TANK-HEIGHT 2)))
(define TANK-MISSILES-NUM 5) ; quantity of the charges the tank has.

(define MISSILE-SPEED (* UFO-SPEED 2))

(define UFO-MISSILE (isosceles-triangle 6 300 "solid" "red"))
(define UFO-MISSILE-ADD 20) ; each pixels

(define HIT-DISTANCE 15) ; pixels between UFO or Tank and a missile centers.


(define INIT-STATE
  (make-game
   (make-ufo UFO-X-START UFO-Y-START '())
   (make-tank TANK-X-START TANK-SPEED '())))

(define TEST-AIM
  (make-game
   (make-ufo 10 20 '())
   (make-tank 28 (- 0 TANK-SPEED) '())))

(define UFO-LAUNCHED (make-ufo 20 100 (list (make-posn 40 120))))

(define TANK-LAUNCHED
  (make-tank 100 TANK-SPEED (list (make-posn 100 TANK-MISSILE-Y-START) (make-posn 20 150))))

(define TEST-LAUNCHED (make-game UFO-LAUNCHED TANK-LAUNCHED))

(define TEST-HIT
  (make-game
   (make-ufo 20 100 '())
   (make-tank 100 TANK-SPEED (list (make-posn 20 103)))))

(define TEST-LANDED
  (make-game
   (make-ufo 70 UFO-Y-LANDED '())
   (make-tank 28 (- 0 TANK-SPEED) (list (make-posn 32 32)))))


;;; Functions

;; GameState -> GameState
;; Usage: (si-main INIT-STATE)
;; Each click on the space key launches a tank missile.
;; By default, the tank has only 5 charges.
;; Move the tank with the left and right arrows.
(define (si-main gs)
  (big-bang gs
    [to-draw si-render]
    [on-tick si-move]
    [on-key si-control]
    [check-with game-state?]
    [stop-when si-game-over? si-render-final]))


;; GameState -> Image
;; Adds Tank, UFO, and Missiles to the BACKGROUND scene.
(define (si-render gs)
  (local (;; Tank -> Image
          (define (tank-render tank scene)
            (place-images (make-list (length (tank-missiles tank)) TANK-MISSILE)
                          (tank-missiles tank)
                          (place-image TANK-IMAGE (tank-x tank) TANK-Y scene)))
          ;; UFO -> Image
          (define (ufo-render ufo scene)
            (place-images (make-list (length (ufo-missiles ufo)) UFO-MISSILE)
                          (ufo-missiles ufo)
                          (place-image UFO-IMAGE (ufo-x ufo) (ufo-y ufo) scene))))
    (tank-render (game-tank gs)
                 (ufo-render (game-ufo gs)
                             BACKGROUND))))


;; GameState -> GameState
;; Moves the game objects on each clock tick.
(define (si-move gs)
  (make-game
   (move-ufo (game-ufo gs))
   (move-tank (game-tank gs))))

;; UFO -> UFO
(define (move-ufo ufo)
  (local (;; Number -> Number
          (define (random-ufo-x x)
            (+ x (if (= 1 (random 2))
                     (random UFO-JUMP-MAX)
                     (- 0 (random UFO-JUMP-MAX)))))

          ;; Number -> Number
          ;; Limits UFO x position to prevent jumping over the scene edges.
          (define (safe-ufo-x x)
            (cond
              [(>= (+ x UFO-JUMP-MAX) UFO-X-MAX) (- x UFO-JUMP-MAX)]
              [(<= (- x UFO-JUMP-MAX) UFO-X-MIN) (+ x UFO-JUMP-MAX)]
              [else x]))

          ;; Missiles -> Missles
          (define (move-missiles missiles)
            (local (;; Posn -> Posn
                    (define (move-missile m)
                      (make-posn (posn-x m) (+ MISSILE-SPEED (posn-y m)))))
              (map move-missile missiles)))

          ;; UFO -> Boolean
          (define (add-missile? ufo)
            (= 0 (modulo (ufo-y ufo) UFO-MISSILE-ADD)))

          ;; UFO -> Posn
          (define (create-missile ufo)
            (make-posn (ufo-x ufo) (+ (/ UFO-HEIGHT 2) (ufo-y ufo)))))
    (make-ufo
     (random-ufo-x (safe-ufo-x (ufo-x ufo)))
     (+ (ufo-y ufo) UFO-SPEED)
     (move-missiles
      (if (add-missile? ufo)
          (cons (create-missile ufo) (ufo-missiles ufo))
          (ufo-missiles ufo))))))

;; Tank -> Tank
;; Returns the next position of the Tank.
(check-expect (move-tank (make-tank 100 TANK-SPEED '()))
              (make-tank (+ 100 TANK-SPEED) TANK-SPEED '()))
(check-expect (move-tank (make-tank 5 (- 0 TANK-SPEED) '()))
              (make-tank TANK-X-MIN TANK-SPEED '()))
(check-expect (move-tank (make-tank WIDTH TANK-SPEED '()))
              (make-tank TANK-X-MAX (- 0 TANK-SPEED) '()))
(define (move-tank tank)
  (local (;; Missiles -> Missiles
          (define (move-missiles missiles)
            (local (;; Posn -> Posn
                    (define (move-missile m)
                      (make-posn (posn-x m) (- (posn-y m) MISSILE-SPEED))))
              (map move-missile missiles))))
    (cond
      [(and (< (tank-vel tank) 0) (<= (tank-x tank) TANK-X-MIN))
       (make-tank TANK-X-MIN TANK-SPEED (move-missiles (tank-missiles tank)))]
      [(and (> (tank-vel tank) 0) (>= (tank-x tank) TANK-X-MAX))
       (make-tank TANK-X-MAX (- 0 TANK-SPEED) (move-missiles (tank-missiles tank)))]
      [else
       (make-tank (+ (tank-x tank) (tank-vel tank))
                  (tank-vel tank)
                  (move-missiles (tank-missiles tank)))])))


;; GameState KeyEvent -> GameState
;; Produces a new game state
;; when one of these keys is pressed:
;; - left [ensures the tank moves left]
;; - right [ensures the tank moves right]
;; - space [launches a missile]
(check-expect (si-control INIT-STATE "left")
              (make-game
               (make-ufo UFO-X-START UFO-Y-START '())
               (make-tank TANK-X-START (- 0 TANK-SPEED) '())))
(check-expect (si-control TEST-HIT "left")
              (make-game
               (game-ufo TEST-HIT)
               (make-tank (tank-x (game-tank TEST-HIT))
                          (- 0 TANK-SPEED)
                          (tank-missiles (game-tank TEST-HIT)))))
(check-expect (si-control TEST-HIT "right") TEST-HIT)
(check-expect (si-control INIT-STATE "right") INIT-STATE)
(check-expect (si-control INIT-STATE " ")
              (make-game
               (game-ufo INIT-STATE)
               (make-tank (tank-x (game-tank INIT-STATE))
                          (tank-vel (game-tank INIT-STATE))
                          (list (make-posn (tank-x (game-tank INIT-STATE)) TANK-MISSILE-Y-START)))))
(check-expect (si-control TEST-HIT " ")
              (make-game
               (game-ufo TEST-HIT)
               (make-tank (tank-x (game-tank TEST-HIT))
                          (tank-vel (game-tank TEST-HIT))
                          (cons (make-posn (tank-x (game-tank TEST-HIT)) TANK-MISSILE-Y-START)
                                (tank-missiles (game-tank TEST-HIT))))))
(check-expect (si-control INIT-STATE "a") INIT-STATE)
(define (si-control gs ke)
  (local (;; KeyEventMove -> Number
          (define (tank-speed ke)
            (cond
              [(string=? ke "left") (- 0 TANK-SPEED)]
              [(string=? ke "right") TANK-SPEED]
              [else (error "Not supported key event")])))
    (cond
      [(or (string=? ke "left") (string=? ke "right"))
       (make-game
        (game-ufo gs)
        (make-tank (tank-x (game-tank gs))
                   (tank-speed ke)
                   (tank-missiles (game-tank gs))))]
      [(and (string=? ke " ") (<= (length (tank-missiles (game-tank gs))) TANK-MISSILES-NUM))
       (make-game
        (game-ufo gs)
        (make-tank (tank-x (game-tank gs))
                   (tank-vel (game-tank gs))
                   (cons (make-posn (tank-x (game-tank gs)) TANK-MISSILE-Y-START)
                         (tank-missiles (game-tank gs)))))]
      [else gs])))


;; GameState -> Boolean
;; Identifies if the game is over due to one of the following:
;; - the UFO landed
;; - Missile hit the UFO
(check-expect (si-game-over? TEST-AIM) #false)
(check-expect (si-game-over? TEST-HIT) #true)
(check-expect (si-game-over? TEST-LANDED) #true)
(define (si-game-over? gs)
  (local (;; UFO -> Boolean
          (define (ufo-landed? ufo)
            (>= (ufo-y ufo) UFO-Y-LANDED)))
    (or (ufo-hit? (game-ufo gs) (tank-missiles (game-tank gs)))
        (tank-hit? (game-tank gs) (ufo-missiles (game-ufo gs)))
        (ufo-landed? (game-ufo gs)))))

;; UFO Missiles-> Boolean
;; Checks if any of Missiles hit the UFO.
(check-expect (ufo-hit? (game-ufo TEST-LANDED) '()) #false)
(check-expect (ufo-hit? (game-ufo TEST-LANDED) (tank-missiles (game-tank TEST-LANDED))) #false)
(check-expect (ufo-hit?  (game-ufo TEST-HIT) (tank-missiles (game-tank TEST-HIT))) #true)
(define (ufo-hit? ufo missiles)
  (local (;; Posn -> Boolean
          (define (ufo-hit*? m)
            (hit? (make-posn (ufo-x ufo) (ufo-y ufo)) m)))
    (ormap ufo-hit*? missiles)))

;; UFO Missiles-> Boolean
;; Checks if any of Missiles hit the Tank.
(check-expect (tank-hit? (make-tank 100 200 '()) '()) #false)
(check-expect (tank-hit? (make-tank 100 200 '()) (list (make-posn 70 150))) #false)
(check-expect (tank-hit?  (make-tank 100 TANK-Y '()) (list (make-posn 110 (- TANK-Y 10)))) #true)
(define (tank-hit? tank missiles)
  (local (;; Posn -> Boolean
          (define (tank-hit*? m)
            (hit? (make-posn (tank-x tank) TANK-Y) m)))
    (ormap tank-hit*? missiles)))

;; Posn Posn -> Boolean
;; Determines whether an object (UFO or Tank) is hit by the missile.
(check-expect (hit? (make-posn 20 20) (make-posn 30 40)) #false)
(check-expect (hit? (make-posn 20 20) (make-posn 20 22)) #true)
(define (hit? p1 p2)
  (<= (integer-sqrt
       (+
        (expt (- (posn-x p1) (posn-x p2)) 2)
        (expt (- (posn-y p1) (posn-y p2)) 2)))
      HIT-DISTANCE))


;; Any -> Boolean
;; Checks that gs is an element of the GameState collection.
(check-expect (game-state? TEST-AIM) #true)
(check-expect (game-state? TEST-HIT) #true)
(check-expect (game-state? 1) #false)
(check-expect (game-state? #true) #false)
(check-expect (game-state? (make-posn 22 33)) #false)
(define (game-state? gs)
  (game? gs))


;; GameState -> Image
;; Renders the last scene of the game.
(check-expect (si-render-final TEST-LANDED)
              (overlay (text "Game Over" 26 "yellow") BACKGROUND))
(check-expect (si-render-final TEST-HIT)
              (overlay (text "YOU WON" 26 "yellow") BACKGROUND))
(define (si-render-final gs)
  (overlay
   (text
    (if (ufo-hit? (game-ufo gs) (tank-missiles (game-tank gs))) "YOU WON" "Game Over")
    26
    "yellow")
   BACKGROUND))


;;; Application

;(si-main INIT-STATE)

