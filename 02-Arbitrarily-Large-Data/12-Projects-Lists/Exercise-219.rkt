;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-219) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 219.
;; Equip your program from exercise 218 with food.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data and Constants Definitions

;; Classic navigation
(define UP "up")
(define DOWN "down")
(define LEFT "left")
(define RIGHT "right")

#|
;; Dvorak navigation
(define UP "c")
(define DOWN "t")
(define LEFT "h")
(define RIGHT "n")
|#

;; A Course is one of these constants:
;; - UP
;; - DOWN
;; - LEFT
;; - RIGHT
;; Represents the direction of the move
;; of an object on the scene.

;; A Coord is one of:
;; - 0
;; - (+ 10 Coord)

;; A Point is a Posn with Coord x and y:
;;    (make-posn Coord Coord)
;; Represents a point of the world's grid.

(define-struct snake [loc course tail])
;; A Snake is a structure:
;;   (make-snake Point Course List-of-points)
;; (make-snake p c t)
;; represents a snake:
;; - with the head located on the point p
;; - with the tail t,
;; - that moves in the direction c.

(define-struct game [snake food])
;; A Game is a structure:
;;   (make-game Snake Point)
;; (make-game s f) represents a world state
;; with the snake s and the food position f.


;;; Constants

(define GAME-SPEED 0.4)

(define GRID-SIZE 10)
(define GRID-COLS 15)
(define GRID-ROWS 15)
(define SCENE-WIDTH (+ GRID-SIZE (* GRID-COLS GRID-SIZE)))
(define SCENE-HEIGHT (+ GRID-SIZE (* GRID-ROWS GRID-SIZE)))

(define SNAKE-RADIUS (/ GRID-SIZE 2))
(define SNAKE-SEGMENT (circle SNAKE-RADIUS "solid" "red"))
(define SNAKE-HEAD (circle SNAKE-RADIUS "outline" "maroon"))

(define SCENE (empty-scene SCENE-WIDTH SCENE-HEIGHT "transparent"))

(define FOOD (circle SNAKE-RADIUS "solid" "green"))

(define FINAL-TEXT-SIZE GRID-SIZE)
(define FINAL-TEXT-COLOR "orange")
(define FINAL-TEXT-POSN (make-posn -5 5))


;;; Tests Constants

(define SNAKE-1 (make-snake (make-posn 50 50) RIGHT '()))
(define SNAKE-3 (make-snake (make-posn 100 150)
                            DOWN
                            (list (make-posn 100 (- 150 GRID-SIZE))
                                  (make-posn (- 100 GRID-SIZE) (- 150 GRID-SIZE)))))
(define SNAKE-5 (make-snake (make-posn 50 50)
                            UP
                            (list (make-posn 50 (+ 50 GRID-SIZE))
                                  (make-posn 50 (+ 50 (* 2 GRID-SIZE)))
                                  (make-posn 50 (+ 50 (* 3 GRID-SIZE)))
                                  (make-posn 50 (+ 50 (* 4 GRID-SIZE))))))
(define SNAKE-HIT (make-snake (make-posn 50 50) RIGHT
                              (list (make-posn (- 50 GRID-SIZE) 50)
                                    (make-posn (- 50 GRID-SIZE) (+ 50 GRID-SIZE))
                                    (make-posn 50 (+ 50 GRID-SIZE))
                                    (make-posn 50 50)
                                    (make-posn 50 (- 50 GRID-SIZE)))))
(define FOOD-INIT (make-posn (+ 50 (* 3 GRID-SIZE)) 50))
(define GAME-INIT (make-game SNAKE-1 FOOD-INIT))


;;; Main Function

;; Game -> Game
;; Launches the program from the initial state.
;; Usage: (main GAME-INIT)
(define (main g0)
  (big-bang g0
    [to-draw render]
    [on-tick tick-handler GAME-SPEED]
    [on-key key-handler]
    [stop-when end? render-final]))


;;; to-draw

;; Game -> Image
;; Produces the image of the world
;; with the snake and the food.
(check-expect (render GAME-INIT) (overlay (draw-snake SNAKE-1) (draw-food FOOD-INIT)))
(define (render g)
  (overlay
   (draw-snake (game-snake g))
   (draw-food (game-food g))))

;; Snake -> Image
;; Produces the image of the snake.
(check-expect (draw-snake SNAKE-1)
              (place-image SNAKE-HEAD
                           (posn-x (snake-loc SNAKE-1))
                           (posn-y (snake-loc SNAKE-1))
                           (place-image SNAKE-SEGMENT
                                        (posn-x (snake-loc SNAKE-1))
                                        (posn-y (snake-loc SNAKE-1))
                                        SCENE)))
(check-expect (draw-snake SNAKE-3)
              (place-image SNAKE-HEAD
                           (posn-x (snake-loc SNAKE-3))
                           (posn-y (snake-loc SNAKE-3))
                           (place-images (make-list 3 SNAKE-SEGMENT)
                                         (append (list (snake-loc SNAKE-3)) (snake-tail SNAKE-3))
                                         SCENE)))
(define (draw-snake s)
  (place-image SNAKE-HEAD
               (posn-x (snake-loc s)) (posn-y (snake-loc s))
               (place-images
                (make-list (+ 1 (length (snake-tail s))) SNAKE-SEGMENT)
                (append (list (snake-loc s)) (snake-tail s))
                SCENE)))

;; Point -> Image
;; Produces the image of the food.
(check-expect (draw-food (make-posn 50 50)) (place-image FOOD 50 50 SCENE))
(check-expect (draw-food (make-posn 30 150)) (place-image FOOD 30 150 SCENE))
(define (draw-food p)
  (place-image FOOD (posn-x p) (posn-y p) SCENE))


;;; on-tick

;; Game -> Game
;; On each world clock tick:
;; - moves the snake
;; - handles the food
;;   - eating
;;   - generation
(check-expect (tick-handler GAME-INIT)
              (make-game (move SNAKE-1) FOOD-INIT))
(check-random (tick-handler (make-game SNAKE-1 (make-posn 50 50)))
              (generate-food (grow SNAKE-1)))
(define (tick-handler g)
  (if (eat? (game-snake g) (game-food g))
      (generate-food (grow (game-snake g)))
      (make-game (move (game-snake g)) (game-food g))))

;; Snake Point -> Boolean
;; Determines whether the snake's head is on the food's position.
(check-expect (eat? SNAKE-1 FOOD-INIT) #false)
(check-expect (eat? SNAKE-1 (make-posn 50 50)) #true)
(define (eat? s p)
  (member? (snake-loc s) (list p)))

;; Snake -> Game
;; Produces the game state after the eating.
(check-random (generate-food SNAKE-3)
              (make-game SNAKE-3 (food-create
                                  (append (list (snake-loc SNAKE-3)) (snake-tail SNAKE-3)))))
(define (generate-food s)
  (make-game s (food-create (append (list (snake-loc s)) (snake-tail s)))))

;; Snake -> Snake
;; Moves the snake and enlarges its tail by one segment.
(check-expect (grow SNAKE-1)
              (make-snake
               (move-head (snake-loc SNAKE-1) (snake-course SNAKE-1))
               (snake-course SNAKE-1)
               (grow-tail SNAKE-1)))
(define (grow s)
  (make-snake
   (move-head (snake-loc s) (snake-course s))
   (snake-course s)
   (grow-tail s)))

;; Snake -> List-of-points
;; Adds the head segment to the snake's tail.
(check-expect (grow-tail SNAKE-1) (list (make-posn 50 50)))
(check-expect (grow-tail SNAKE-3) (cons (snake-loc SNAKE-3) (snake-tail SNAKE-3)))
(define (grow-tail s)
  (cons (snake-loc s) (snake-tail s)))

;; Snake -> Snake
;; Moves the snake.
(check-expect (move SNAKE-1)
              (make-snake
               (move-head (snake-loc SNAKE-1) (snake-course SNAKE-1))
               (snake-course SNAKE-1)
               (move-tail (snake-tail SNAKE-1) (snake-loc SNAKE-1))))
(define (move s)
  (make-snake
   (move-head (snake-loc s) (snake-course s))
   (snake-course s)
   (move-tail (snake-tail s) (snake-loc s))))

;; Point Course -> Point
;; Produces the Point of the new position of the snake.
(check-expect (move-head (make-posn 50 100) UP)
              (make-posn 50 (- 100 GRID-SIZE)))
(check-expect (move-head (make-posn 50 100) DOWN)
              (make-posn 50 (+ 100 GRID-SIZE)))
(check-expect (move-head (make-posn 50 100) LEFT)
              (make-posn (- 50 GRID-SIZE) 100))
(check-expect (move-head (make-posn 50 100) RIGHT)
              (make-posn (+ 50 GRID-SIZE) 100))
(define (move-head loc course)
  (cond
    [(string=? UP course)
     (make-posn (posn-x loc) (- (posn-y loc) GRID-SIZE))]
    [(string=? DOWN course)
     (make-posn (posn-x loc) (+ (posn-y loc) GRID-SIZE))]
    [(string=? LEFT course)
     (make-posn (- (posn-x loc) GRID-SIZE) (posn-y loc))]
    [(string=? RIGHT course)
     (make-posn (+ (posn-x loc) GRID-SIZE) (posn-y loc))]))

;; List-of-points Point -> List-of-points
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


;;; on-key

;; Game KeyEvent -> Game
;; Enables a player to control the movement of the snake
;; with the four arrow keys.
(check-expect (key-handler GAME-INIT "a") GAME-INIT)
(check-expect (key-handler GAME-INIT UP) (make-game (set-course SNAKE-1 UP) FOOD-INIT))
(check-expect (key-handler GAME-INIT DOWN) (make-game (set-course SNAKE-1 DOWN) FOOD-INIT))
(check-expect (key-handler GAME-INIT LEFT) (make-game (set-course SNAKE-1 LEFT) FOOD-INIT))
(check-expect (key-handler GAME-INIT RIGHT) (make-game (set-course SNAKE-1 RIGHT) FOOD-INIT))
(define (key-handler g k)
  (cond
    [(or (key=? UP k) (key=? DOWN k) (key=? LEFT k) (key=? RIGHT k))
     (make-game (set-course (game-snake g) k) (game-food g))]
    [else g]))

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


;;; stop-when

;; Snake -> Boolean
;; Determines whether the game is over:
;; the snake hits a scene border.
(check-expect (end? GAME-INIT) #false)
(check-expect (end? (make-game (make-snake (make-posn 50 0) UP '()) FOOD-INIT)) #true)
(check-expect (end? (make-game (make-snake (make-posn 50 (+ SCENE-HEIGHT 1)) DOWN '()) FOOD-INIT))
              #true)
(check-expect (end? (make-game (make-snake (make-posn 0 50) LEFT '()) FOOD-INIT)) #true)
(check-expect (end? (make-game (make-snake (make-posn (+ SCENE-WIDTH 1) 50) RIGHT '()) FOOD-INIT))
              #true)
(check-expect (end? (make-game SNAKE-HIT FOOD-INIT)) #true)
(define (end? g)
  (or (hit-wall? (game-snake g)) (hit-itself? (game-snake g))))

;; Snake -> Boolean
;; Determines whether the snake hit the scene border.
(check-expect (hit-wall? SNAKE-3) #false)
(check-expect (hit-wall? (make-snake (make-posn 50 0) UP '())) #true)
(check-expect (hit-wall? (make-snake (make-posn 50 (+ SCENE-HEIGHT 1)) DOWN '())) #true)
(check-expect (hit-wall? (make-snake (make-posn 0 50) LEFT '())) #true)
(check-expect (hit-wall? (make-snake (make-posn (+ SCENE-WIDTH 1) 50) RIGHT '())) #true)
(define (hit-wall? s)
  (not (member? (snake-loc s) GRID)))

;; Snake -> Boolean
;; Determines whether the snake hit itself.
(check-expect (hit-itself? SNAKE-1) #false)
(check-expect (hit-itself? SNAKE-3) #false)
(check-expect (hit-itself? SNAKE-5) #false)
(check-expect (hit-itself? SNAKE-HIT) #true)
(define (hit-itself? s)
  (member? (snake-loc s) (snake-tail s)))


;; Game -> Image
;; Produces the final scene.
(check-expect (render-final (make-game (make-snake (make-posn 50 0) UP '()) FOOD-INIT))
              (overlay/align/offset
               "left" "bottom"
               (text "Snake hit border: 1" FINAL-TEXT-SIZE FINAL-TEXT-COLOR)
               (posn-x FINAL-TEXT-POSN) (posn-y FINAL-TEXT-POSN)
               (render (make-game (make-snake (make-posn 50 0) UP '()) FOOD-INIT))))
(check-expect (render-final (make-game SNAKE-HIT FOOD-INIT))
              (overlay/align/offset
               "left" "bottom"
               (text "Snake hit itself: 6" FINAL-TEXT-SIZE FINAL-TEXT-COLOR)
               (posn-x FINAL-TEXT-POSN) (posn-y FINAL-TEXT-POSN)
               (render (make-game SNAKE-HIT FOOD-INIT))))
(define (render-final g)
  (overlay/align/offset
   "left" "bottom"
   (text
    (string-append
     (if (hit-itself? (game-snake g)) "Snake hit itself: " "Snake hit border: ")
     (number->string (+ 1 (length (snake-tail (game-snake g))))))
    FINAL-TEXT-SIZE FINAL-TEXT-COLOR)
   (posn-x FINAL-TEXT-POSN) (posn-y FINAL-TEXT-POSN)
   (render g)))


;;; Food Generator

;; PositiveNumber PositiveNumber -> List-of-points
;; Produces a list of points of the grid
;; with the given number of the rows and columns.
(check-expect (generate-grid 1 1) (list (make-posn GRID-SIZE GRID-SIZE)))
(check-expect (generate-grid 1 2)
              (list (make-posn GRID-SIZE (* 2 GRID-SIZE)) (make-posn GRID-SIZE GRID-SIZE)))
(check-expect (generate-grid 2 1)
              (list (make-posn (* 2 GRID-SIZE) GRID-SIZE) (make-posn GRID-SIZE GRID-SIZE)))
(check-expect (generate-grid 2 2)
              (list (make-posn (* 2 GRID-SIZE) (* 2 GRID-SIZE))
                    (make-posn GRID-SIZE (* 2 GRID-SIZE))
                    (make-posn (* 2 GRID-SIZE) GRID-SIZE)
                    (make-posn GRID-SIZE GRID-SIZE)))
(define (generate-grid row col)
  (cond
    [(= 1 col) (generate-row row col)]
    [else (append (generate-row row col) (generate-grid row (sub1 col)))]))

;; PositiveNumber PositiveNumber -> List-of-points
;; Produces a list of the points of the grid row.
(check-expect (generate-row 1 1) (list (make-posn GRID-SIZE GRID-SIZE)))
(check-expect (generate-row 2 1)
              (list (make-posn (* 2 GRID-SIZE) GRID-SIZE) (make-posn GRID-SIZE GRID-SIZE)))
(check-expect (generate-row 3 1)
              (list (make-posn (* 3 GRID-SIZE) GRID-SIZE)
                    (make-posn (* 2 GRID-SIZE) GRID-SIZE)
                    (make-posn GRID-SIZE GRID-SIZE)))
(check-expect (generate-row 1 2) (list (make-posn GRID-SIZE (* 2 GRID-SIZE))))
(check-expect (generate-row 2 2)
              (list (make-posn (* 2 GRID-SIZE) (* 2 GRID-SIZE))
                    (make-posn GRID-SIZE (* 2 GRID-SIZE))))
(check-expect (generate-row 3 2)
              (list (make-posn (* 3 GRID-SIZE) (* 2 GRID-SIZE))
                    (make-posn (* 2 GRID-SIZE) (* 2 GRID-SIZE))
                    (make-posn GRID-SIZE (* 2 GRID-SIZE))))
(define (generate-row length index)
  (cond
    [(= 1 length) (list (make-posn GRID-SIZE (* index GRID-SIZE)))]
    [else (append
           (list (make-posn (* length GRID-SIZE) (* index GRID-SIZE)))
           (generate-row (sub1 length) index))]))

(define GRID (generate-grid GRID-COLS GRID-ROWS))

;; List-of-points -> Point
;; Produces the position of the food,
;; not equal the position of the snake.
(check-satisfied (food-create (list (make-posn 10 10))) not=-10-10?)
(define (food-create lp)
  (food-check-create lp (list-ref GRID (random (length GRID)))))

;; List-of-posns Posn -> Posn
;; Generative recursion.
;; Returns the position of the food
;; or - if the candidate equals the snake's head location -
;; calls food-create for new generation attempt.
(check-expect (food-check-create (list (make-posn 10 10)) (make-posn 20 30)) (make-posn 20 30))
(define (food-check-create lp candidate)
  (if (member? candidate lp) (food-create lp) candidate))

;; Posn -> Boolean
;; Use for testing only.
(define (not=-10-10? p)
  (not (and (= (posn-x p) 10) (= (posn-y p) 10))))


;;; Application

(main GAME-INIT)

