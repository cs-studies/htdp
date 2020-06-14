;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-216) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 216.
;; Modify your program from exercise 215
;; so that it stops if the worm has reached the walls of the world.
;; When the program stops because of this condition,
;; it should render the final scene with the text
;; "worm hit border" in the lower left of the world scene.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data and Constants Definitions

(define UP "up")
(define DOWN "down")
(define LEFT "left")
(define RIGHT "right")

;; A Course is one of these constants:
;; - UP
;; - DOWN
;; - LEFT
;; - RIGHT
;; Represents the direction of the move
;; of an object on the scene.


(define-struct snake [loc course length])
;; A Snake is a structure:
;;   (make-snake Posn Course PositiveNumber)
;; (make-snake (make-posn x y) c l)
;; represents a snake of the length l,
;; whose head is located on (x, y) coordinates
;; and moves in the direction c.


;;; Constants

(define SNAKE-RADIUS 5)
(define SNAKE-DIAMETER (* 2 SNAKE-RADIUS))
(define SNAKE-SEGMENT (circle SNAKE-RADIUS "solid" "red"))
(define SNAKE-VELOCITY SNAKE-DIAMETER)

(define SCENE-WIDTH (* 20 SNAKE-DIAMETER))
(define SCENE-HEIGHT (* 20 SNAKE-DIAMETER))
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT "white"))

(define SNAKE-INIT-X (/ SCENE-WIDTH 2))
(define SNAKE-INIT-Y (/ SCENE-HEIGHT 4))
(define SNAKE-INIT-LENGTH 1)
(define SNAKE-INIT (make-snake
                    (make-posn SNAKE-INIT-X SNAKE-INIT-Y)
                    RIGHT
                    SNAKE-INIT-LENGTH))


;;; Functions

;; Snake -> Snake
;; Launches the program from the initial state.
;; Usage: (main SNAKE-INIT)
(define (main s0)
  (big-bang s0
    [to-draw render]
    [on-tick tick-handler 1]
    [on-key key-handler]
    [stop-when end? render-final]))

;; Snake -> Image
;; Produces the image of the world.
(check-expect (render SNAKE-INIT) (draw-snake SNAKE-INIT))
(define (render s)
  (draw-snake s))

;; Snake -> Image
;; Produces the image of the 1 segment snake.
(check-expect (draw-snake SNAKE-INIT)
              (place-image SNAKE-SEGMENT
                           (posn-x (snake-loc SNAKE-INIT))
                           (posn-y (snake-loc SNAKE-INIT))
                           SCENE))
(define (draw-snake s)
  (place-image
   SNAKE-SEGMENT
   (posn-x (snake-loc s))
   (posn-y (snake-loc s))
   SCENE))

;; Snake -> Snake
;; Moves the snake on each world clock tick.
(check-expect (tick-handler SNAKE-INIT) (move SNAKE-INIT SNAKE-VELOCITY))
(define (tick-handler s)
  (move s SNAKE-VELOCITY))

;; Snake PositiveNumber -> Snake
;; Moves the snake on the given distance d.
(check-expect (move (make-snake (make-posn 50 100) UP 7) SNAKE-VELOCITY)
              (make-snake (make-posn 50 (- 100 SNAKE-VELOCITY)) UP 7))
(check-expect (move (make-snake (make-posn 50 100) DOWN 7) SNAKE-VELOCITY)
              (make-snake (make-posn 50 (+ 100 SNAKE-VELOCITY)) DOWN 7))
(check-expect (move (make-snake (make-posn 50 100) LEFT 7) SNAKE-VELOCITY)
              (make-snake (make-posn (- 50 SNAKE-VELOCITY) 100) LEFT 7))
(check-expect (move (make-snake (make-posn 50 100) RIGHT 7) SNAKE-VELOCITY)
              (make-snake (make-posn (+ 50 SNAKE-VELOCITY) 100) RIGHT 7))
(define (move s d)
  (make-snake
   (cond
     [(string=? UP (snake-course s))
      (make-posn (posn-x (snake-loc s)) (- (posn-y (snake-loc s)) d))]
     [(string=? DOWN (snake-course s))
      (make-posn (posn-x (snake-loc s)) (+ (posn-y (snake-loc s)) d))]
     [(string=? LEFT (snake-course s))
      (make-posn (- (posn-x (snake-loc s)) d) (posn-y (snake-loc s)))]
     [(string=? RIGHT (snake-course s))
      (make-posn (+ (posn-x (snake-loc s)) d) (posn-y (snake-loc s)))])
   (snake-course s)
   (snake-length s)))

;; Snake KeyEvent -> Snake
;; Enables a player to control the movement of the snake
;; with the four arrow keys.
(check-expect (key-handler SNAKE-INIT "a") SNAKE-INIT)
(check-expect (key-handler SNAKE-INIT "up") (set-course SNAKE-INIT UP))
(check-expect (key-handler SNAKE-INIT "down") (set-course SNAKE-INIT DOWN))
(check-expect (key-handler SNAKE-INIT "left") (set-course SNAKE-INIT LEFT))
(check-expect (key-handler SNAKE-INIT "right") (set-course SNAKE-INIT RIGHT))
(define (key-handler s k)
  (cond
    [(or (key=? UP k) (key=? DOWN k) (key=? LEFT k) (key=? RIGHT k))
     (set-course s k)]
    [else s]))

;; Snake Course -> Snake
;; Changes the snake's course.
(check-expect (set-course SNAKE-INIT UP)
              (make-snake (snake-loc SNAKE-INIT) UP SNAKE-INIT-LENGTH))
(check-expect (set-course SNAKE-INIT DOWN)
              (make-snake (snake-loc SNAKE-INIT) DOWN SNAKE-INIT-LENGTH))
(check-expect (set-course SNAKE-INIT LEFT)
              (make-snake (snake-loc SNAKE-INIT) LEFT SNAKE-INIT-LENGTH))
(check-expect (set-course SNAKE-INIT RIGHT)
              (make-snake (snake-loc SNAKE-INIT) RIGHT SNAKE-INIT-LENGTH))
(define (set-course s course)
  (make-snake (snake-loc s) course (snake-length s)))

;; Snake -> Boolean
;; Determines whether the game is over:
;; the snake hits a scene border.
(check-expect (end? SNAKE-INIT) #false)
(check-expect (end? (make-snake (make-posn 50 0) UP 7)) #true)
(check-expect (end? (make-snake (make-posn 50 (+ SCENE-HEIGHT 1)) DOWN 7)) #true)
(check-expect (end? (make-snake (make-posn 0 50) LEFT 7)) #true)
(check-expect (end? (make-snake (make-posn (+ SCENE-WIDTH 1) 50) RIGHT 7)) #true)
(define (end? s)
  (or (< (posn-x (snake-loc s)) SNAKE-RADIUS)
      (> (posn-x (snake-loc s)) (- SCENE-WIDTH SNAKE-RADIUS))
      (< (posn-y (snake-loc s)) SNAKE-RADIUS)
      (> (posn-y (snake-loc s)) (- SCENE-HEIGHT SNAKE-RADIUS))))

;; Snake -> Image
;; Produces the final scene.
(check-expect (render-final SNAKE-INIT)
              (overlay/align/offset "left" "bottom"
                                    (text "worm hit border" 18 "orange")
                                    -10 5
                                    (draw-snake SNAKE-INIT)))
(define (render-final s)
  (overlay/align/offset "left" "bottom"
                        (text "worm hit border" 18 "orange")
                        -10 5
                        (draw-snake s)))


;;; Application

;(main SNAKE-INIT)

