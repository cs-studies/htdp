;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-218) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 218.
;; Redesign your program from exercise 217 so that it stops
;; if the worm has run into the walls of the world or into itself.
;; Display a message like the one in exercise 216
;; to explain whether the program stopped
;; because the worm hit the wall or because it ran into itself.


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


(define-struct snake [loc course tail])
;; A Snake is a structure:
;;   (make-snake Posn Course List-of-posns)
;; (make-snake (make-posn x y) c t)
;; represents a snake:
;; - with the head located on (x, y) coordinates
;; - with the tail t,
;; - that moves in the direction c.


;;; Constants

(define SNAKE-RADIUS 5)
(define SNAKE-DIAMETER (* 2 SNAKE-RADIUS))
(define SNAKE-SEGMENT (circle SNAKE-RADIUS "solid" "red"))
(define SNAKE-VELOCITY SNAKE-DIAMETER)

(define SCENE-WIDTH (* 20 SNAKE-DIAMETER))
(define SCENE-HEIGHT (* 20 SNAKE-DIAMETER))
(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT "white"))

(define FINAL-TEXT-SIZE 18)
(define FINAL-TEXT-COLOR "orange")
(define FINAL-TEXT-POSN (make-posn -10 5))

;;; Tests Constants

(define SNAKE-1 (make-snake (make-posn (/ SCENE-WIDTH 2) (/ SCENE-HEIGHT 4)) RIGHT '()))
(define SNAKE-3 (make-snake (make-posn 100 150)
                            DOWN
                            (list (make-posn 100 (- 150 SNAKE-DIAMETER))
                                  (make-posn (- 100 SNAKE-DIAMETER) (- 150 SNAKE-DIAMETER)))))
(define SNAKE-5 (make-snake (make-posn 50 50)
                            UP
                            (list (make-posn 50 (+ 50 SNAKE-DIAMETER))
                                  (make-posn 50 (+ 50 (* 2 SNAKE-DIAMETER)))
                                  (make-posn 50 (+ 50 (* 3 SNAKE-DIAMETER)))
                                  (make-posn 50 (+ 50 (* 4 SNAKE-DIAMETER))))))
(define SNAKE-HIT (make-snake (make-posn 50 50) RIGHT
                              (list (make-posn (- 50 SNAKE-DIAMETER) 50)
                                    (make-posn (- 50 SNAKE-DIAMETER) (+ 50 SNAKE-DIAMETER))
                                    (make-posn 50 (+ 50 SNAKE-DIAMETER))
                                    (make-posn 50 50)
                                    (make-posn 50 (- 50 SNAKE-DIAMETER)))))


;;; Functions

;; Snake -> Snake
;; Launches the program from the initial state.
;; Usage: (main SNAKE-5)
(define (main s0)
  (big-bang s0
    [to-draw render]
    [on-tick tick-handler 1]
    [on-key key-handler]
    [stop-when end? render-final]))

;; Snake -> Image
;; Produces the image of the world.
(check-expect (render SNAKE-1) (draw-snake SNAKE-1))
(define (render s)
  (draw-snake s))

;; Snake -> Image
;; Produces the image of the snake.
(check-expect (draw-snake SNAKE-1)
              (place-image SNAKE-SEGMENT
                           (posn-x (snake-loc SNAKE-1))
                           (posn-y (snake-loc SNAKE-1))
                           SCENE))
(check-expect (draw-snake SNAKE-3)
              (place-images (make-list 3 SNAKE-SEGMENT)
                            (append (list (snake-loc SNAKE-3)) (snake-tail SNAKE-3))
                            SCENE))
(define (draw-snake s)
  (place-images
   (make-list (+ 1 (length (snake-tail s))) SNAKE-SEGMENT)
   (append (list (snake-loc s)) (snake-tail s))
   SCENE))

;; Snake -> Snake
;; Moves the snake on each world clock tick.
(check-expect (tick-handler SNAKE-1) (move SNAKE-1 SNAKE-VELOCITY))
(define (tick-handler s)
  (move s SNAKE-VELOCITY))

;; Snake PositiveNumber -> Snake
;; Moves the snake on the given distance d.
(check-expect (move SNAKE-1 SNAKE-VELOCITY)
              (make-snake
               (move-head (snake-loc SNAKE-1) (snake-course SNAKE-1) SNAKE-VELOCITY)
               (snake-course SNAKE-1)
               (move-tail (snake-tail SNAKE-1) (snake-loc SNAKE-1))))
(define (move s d)
  (make-snake
   (move-head (snake-loc s) (snake-course s) d)
   (snake-course s)
   (move-tail (snake-tail s) (snake-loc s))))

;; Posn Course PositiveNumber -> Posn
;; Produces the Posn of the new position of the snake.
(check-expect (move-head (make-posn 50 100) UP SNAKE-VELOCITY)
              (make-posn 50 (- 100 SNAKE-VELOCITY)))
(check-expect (move-head (make-posn 50 100) DOWN SNAKE-VELOCITY)
              (make-posn 50 (+ 100 SNAKE-VELOCITY)))
(check-expect (move-head (make-posn 50 100) LEFT SNAKE-VELOCITY)
              (make-posn (- 50 SNAKE-VELOCITY) 100))
(check-expect (move-head (make-posn 50 100) RIGHT SNAKE-VELOCITY)
              (make-posn (+ 50 SNAKE-VELOCITY) 100))
(define (move-head loc course d)
  (cond
    [(string=? UP course)
     (make-posn (posn-x loc) (- (posn-y loc) d))]
    [(string=? DOWN course)
     (make-posn (posn-x loc) (+ (posn-y loc) d))]
    [(string=? LEFT course)
     (make-posn (- (posn-x loc) d) (posn-y loc))]
    [(string=? RIGHT course)
     (make-posn (+ (posn-x loc) d) (posn-y loc))]))

;; List-of-posns Posn -> List-of-posns
;; Prepends new tail segment and removes the last one.
(check-expect (move-tail '() (make-posn 30 100)) '())
(check-expect (move-tail (list (make-posn 20 100)) (make-posn 30 100))
              (list (make-posn 30 100)))
(check-expect (move-tail (list (make-posn 20 100) (make-posn 20 90)) (make-posn 30 100))
              (list (make-posn 30 100) (make-posn 20 100)))
(define (move-tail tail head)
  (cond
    [(empty? tail) '()]
    [else (cons head (reverse (rest (reverse tail))))]))

;; Snake KeyEvent -> Snake
;; Enables a player to control the movement of the snake
;; with the four arrow keys.
(check-expect (key-handler SNAKE-1 "a") SNAKE-1)
(check-expect (key-handler SNAKE-1 "up") (set-course SNAKE-1 UP))
(check-expect (key-handler SNAKE-1 "down") (set-course SNAKE-1 DOWN))
(check-expect (key-handler SNAKE-1 "left") (set-course SNAKE-1 LEFT))
(check-expect (key-handler SNAKE-1 "right") (set-course SNAKE-1 RIGHT))
(define (key-handler s k)
  (cond
    [(or (key=? UP k) (key=? DOWN k) (key=? LEFT k) (key=? RIGHT k))
     (set-course s k)]
    [else s]))

;; Snake Course -> Snake
;; Changes the snake's course.
(check-expect (set-course SNAKE-1 UP)
              (make-snake (snake-loc SNAKE-1) UP '()))
(check-expect (set-course SNAKE-1 DOWN)
              (make-snake (snake-loc SNAKE-1) DOWN '()))
(check-expect (set-course SNAKE-1 LEFT)
              (make-snake (snake-loc SNAKE-1) LEFT '()))
(check-expect (set-course SNAKE-1 RIGHT)
              (make-snake (snake-loc SNAKE-1) RIGHT '()))
(define (set-course s course)
  (make-snake (snake-loc s) course (snake-tail s)))

;; Snake -> Boolean
;; Determines whether the game is over:
;; the snake hits a scene border.
(check-expect (end? SNAKE-1) #false)
(check-expect (end? (make-snake (make-posn 50 0) UP '())) #true)
(check-expect (end? (make-snake (make-posn 50 (+ SCENE-HEIGHT 1)) DOWN '())) #true)
(check-expect (end? (make-snake (make-posn 0 50) LEFT '())) #true)
(check-expect (end? (make-snake (make-posn (+ SCENE-WIDTH 1) 50) RIGHT '())) #true)
(check-expect (end? SNAKE-HIT) #true)
(define (end? s)
  (or (hit-wall? s) (hit-itself? s)))

;; Snake -> Boolean
;; Determines whether the snake hit the scene border.
(check-expect (hit-wall? SNAKE-3) #false)
(check-expect (hit-wall? (make-snake (make-posn 50 0) UP '())) #true)
(check-expect (hit-wall? (make-snake (make-posn 50 (+ SCENE-HEIGHT 1)) DOWN '())) #true)
(check-expect (hit-wall? (make-snake (make-posn 0 50) LEFT '())) #true)
(check-expect (hit-wall? (make-snake (make-posn (+ SCENE-WIDTH 1) 50) RIGHT '())) #true)
(define (hit-wall? s)
  (or (< (posn-x (snake-loc s)) SNAKE-RADIUS)
      (> (posn-x (snake-loc s)) (- SCENE-WIDTH SNAKE-RADIUS))
      (< (posn-y (snake-loc s)) SNAKE-RADIUS)
      (> (posn-y (snake-loc s)) (- SCENE-HEIGHT SNAKE-RADIUS))))

;; Snake -> Boolean
;; Determines whether the snake hit itself.
(check-expect (hit-itself? SNAKE-1) #false)
(check-expect (hit-itself? SNAKE-3) #false)
(check-expect (hit-itself? SNAKE-5) #false)
(check-expect (hit-itself? SNAKE-HIT) #true)
(define (hit-itself? s)
  (member? (snake-loc s) (snake-tail s)))


;; Snake -> Image
;; Produces the final scene.
(check-expect (render-final (make-snake (make-posn 50 0) UP '()))
              (overlay/align/offset "left" "bottom"
                                    (text "Snake hit border: 1" FINAL-TEXT-SIZE FINAL-TEXT-COLOR)
                                    (posn-x FINAL-TEXT-POSN) (posn-y FINAL-TEXT-POSN)
                                    (draw-snake (make-snake (make-posn 50 0) UP '()))))
(check-expect (render-final SNAKE-HIT)
              (overlay/align/offset "left" "bottom"
                                    (text "Snake hit itself: 6" FINAL-TEXT-SIZE FINAL-TEXT-COLOR)
                                    (posn-x FINAL-TEXT-POSN) (posn-y FINAL-TEXT-POSN)
                                    (draw-snake SNAKE-HIT)))
(define (render-final s)
  (overlay/align/offset "left" "bottom"
                        (text
                         (string-append
                          (if (hit-itself? s) "Snake hit itself: " "Snake hit border: ")
                          (number->string (+ 1 (length (snake-tail s)))))
                         FINAL-TEXT-SIZE FINAL-TEXT-COLOR)
                        (posn-x FINAL-TEXT-POSN) (posn-y FINAL-TEXT-POSN)
                        (draw-snake s)))


;;; Application

;(main SNAKE-5)

