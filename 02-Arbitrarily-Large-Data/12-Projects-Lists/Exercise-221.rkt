;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-221) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 221.
;; Design the interactive program tetris-main,
;; which displays blocks dropping in a straight line from the top of the canvas and
;; landing on the floor or on blocks that are already resting.
;; The input to tetris-main should determine the rate at which the clock ticks.


(require 2htdp/image)
(require 2htdp/universe)


;;; Data Definitions

;; An N is one of:
;; – 0
;; – (add1 N)
;; Represents the counting numbers.

(define-struct block [x y])
;; A Block is a structure:
;;   (make-block N N)
;; (make-block x y) depicts a block whose
;; left corner is (* x SIZE) pixels from the left
;; and (* y SIZE) pixels from the top;

;; A Landscape is one of:
;; - '()
;; - (cons Block Landscape)

(define-struct tetris [block landscape])
;; A Tetris is a structure:
;;   (make-tetris Block Lanscape)
;; (make-tetris b0 (list b1 b2 ...)) means
;; b0 is the dropping block,
;; while b1, b2, and ... are resting blocks.


;;; Constants

(define WIDTH 10) ; # of blocks, horizontally
(define HEIGHT WIDTH)
(define SIZE 10) ; blocks are squares
(define SCENE-CENTER (- (/ WIDTH 2) 1))
(define SCENE-SIZE (* WIDTH SIZE))

(define SHIFT (/ SIZE 2)) ; distance between a block's edge and center

(define BLOCK ; red squares with black rims
  (overlay
   (square SIZE "outline" "black")
   (square SIZE "solid" "red")))

(define SCENE (empty-scene SCENE-SIZE SCENE-SIZE "white"))

(define BLOCK-NEW (make-block SCENE-CENTER 0))


;;; Data Examples

(define BLOCK-0 (make-block 0 0))

(define BLOCK-3 (make-block 3 5))

(define BLOCK-LAND (make-block (/ WIDTH 2) (- HEIGHT 1)))

(define BLOCK-ON-BLOCK (make-block (/ WIDTH 2) (- HEIGHT 2)))

(define BLOCK-LAND-CORNER (make-block (- WIDTH 1) (- HEIGHT 1)))

(define TETRIS-0 (make-tetris BLOCK-0 '()))

(define TETRIS-1 (make-tetris BLOCK-3 '()))

(define TETRIS-2 (make-tetris BLOCK-0 (list BLOCK-LAND)))

(define TETRIS-3 (make-tetris BLOCK-3 (list BLOCK-LAND-CORNER BLOCK-LAND)))

(define TETRIS-4 (make-tetris BLOCK-0 (list BLOCK-ON-BLOCK BLOCK-LAND-CORNER BLOCK-LAND)))


;;; Functions

;; PositiveNumber -> Image
;; Usage: (tetris-main 1)
(define (tetris-main rate) ; the clock ticks every rate seconds
  (big-bang (make-tetris BLOCK-NEW '())
    [to-draw tetris-render]
    [on-tick tick-handler rate]))


;; Tetris -> Image
;; Turns a given instance of Tetris into an image.
(check-expect (tetris-render TETRIS-0)
              (place-images (list BLOCK) (tetris->posns TETRIS-0) SCENE))
(check-expect (tetris-render TETRIS-3)
              (place-images (make-list 3 BLOCK) (tetris->posns TETRIS-3) SCENE))
(define (tetris-render t)
  (place-images
   (make-list (add1 (length (tetris-landscape t))) BLOCK)
   (tetris->posns t)
   SCENE))

;; Tetris -> List-of-posns
;; Converts a given instance of Tetris into the list of Posns.
(check-expect (tetris->posns TETRIS-0) (list (make-posn SHIFT SHIFT)))
(check-expect (tetris->posns TETRIS-1) (list (block->posn BLOCK-3)))
(check-expect (tetris->posns TETRIS-2) (list (block->posn BLOCK-0) (block->posn BLOCK-LAND)))
(check-expect (tetris->posns TETRIS-3)
              (list (block->posn BLOCK-3) (block->posn BLOCK-LAND-CORNER) (block->posn BLOCK-LAND)))
(check-expect (tetris->posns TETRIS-4)
              (list (block->posn BLOCK-0)
                    (block->posn BLOCK-ON-BLOCK)
                    (block->posn BLOCK-LAND-CORNER)
                    (block->posn BLOCK-LAND)))
(define (tetris->posns t)
  (cons (block->posn (tetris-block t)) (landscape->posns (tetris-landscape t))))

;; Block -> Posn
;; Converts a given instance of Block into the Posn.
(check-expect (block->posn BLOCK-0) (make-posn SHIFT SHIFT))
(check-expect (block->posn BLOCK-3) (make-posn (N->coord 3) (N->coord 5)))
(define (block->posn b)
  (make-posn (N->coord (block-x b)) (N->coord (block-y b))))

;; N -> N
;; Converts a given block x or y position to a coordinate.
(check-expect (N->coord 0) SHIFT)
(check-expect (N->coord 3) (+ (* SIZE 3) SHIFT))
(define (N->coord n)
  (+ (* SIZE n) SHIFT))

;; Landscape -> List-of-posns
;; Converts a given Landscape into the list of posns.
(check-expect (landscape->posns '()) '())
(check-expect (landscape->posns (list BLOCK-0)) (list (block->posn BLOCK-0)))
(check-expect (landscape->posns (list BLOCK-0 BLOCK-3))
              (list (block->posn BLOCK-0) (block->posn BLOCK-3)))
(define (landscape->posns l)
  (cond
    [(empty? l) '()]
    [else (cons (block->posn (first l)) (landscape->posns (rest l)))]))


;; Tetris -> Tetris
;; Moves down or adds a block.
(check-expect (tick-handler (make-tetris BLOCK-NEW '()))
              (make-tetris (move-down BLOCK-NEW) '()))
(check-expect (tick-handler (make-tetris (make-block SCENE-CENTER (- HEIGHT 1)) '()))
              (make-tetris BLOCK-NEW (list (make-block SCENE-CENTER (- HEIGHT 1)))))
(check-expect (tick-handler (make-tetris (make-block SCENE-CENTER (- HEIGHT 2))
                            (list (make-block SCENE-CENTER (- HEIGHT 1)))))
              (make-tetris BLOCK-NEW
                           (list (make-block SCENE-CENTER (- HEIGHT 2))
                                 (make-block SCENE-CENTER (- HEIGHT 1)))))
(define (tick-handler t)
  (if (block-landed? t)
      (make-tetris BLOCK-NEW (cons (tetris-block t) (tetris-landscape t)))
      (make-tetris (move-down (tetris-block t)) (tetris-landscape t))))

;; Tetris -> Boolean
;; Determines whether the block has landed.
(check-expect (block-landed? TETRIS-0) #false)
(check-expect (block-landed? (make-tetris (make-block SCENE-CENTER (- HEIGHT 2)) '())) #false)
(check-expect (block-landed? (make-tetris (make-block SCENE-CENTER (- HEIGHT 1)) '())) #true)
(check-expect (block-landed?
               (make-tetris
                (make-block SCENE-CENTER (- HEIGHT 2))
                (list (make-block SCENE-CENTER (- HEIGHT 1)))))
              #true)
(define (block-landed? t)
  (or (member? (move-down (tetris-block t)) (tetris-landscape t))
      (= (block-y (tetris-block t)) (- HEIGHT 1))))

;; Block -> Block
;; Moves the given block down.
(check-expect (move-down (make-block 0 0)) (make-block 0 1))
(check-expect (move-down (make-block 3 5)) (make-block 3 6))
(define (move-down b)
  (make-block (block-x b) (add1 (block-y b))))


;;; Application

;(tetris-main 0.5)

