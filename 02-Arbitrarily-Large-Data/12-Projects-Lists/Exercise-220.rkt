;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-220) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 220.
;; Design the program tetris-render,
;; which turns a given instance of Tetris into an Image.


(require 2htdp/image)


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
(define SCENE-SIZE (* WIDTH SIZE))

(define SHIFT (/ SIZE 2)) ; distance between a block's edge and center

(define BLOCK ; red squares with black rims
  (overlay
   (square SIZE "outline" "black")
   (square SIZE "solid" "red")))

(define SCENE (empty-scene SCENE-SIZE SCENE-SIZE "white"))


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


;;; Application

(tetris-render TETRIS-2)
(tetris-render TETRIS-3)
(tetris-render TETRIS-4)

(tetris-render
 (make-tetris
  (make-block 0 0)
  (list (make-block 5 1) (make-block 5 2) (make-block 5 3) (make-block 5 4)
        (make-block 5 5) (make-block 5 6) (make-block 5 7) (make-block 5 8) (make-block 5 9))))

(tetris-render
 (make-tetris
  (make-block 9 0)
  (list (make-block 0 9) (make-block 1 9) (make-block 2 9) (make-block 3 9) (make-block 4 9)
        (make-block 5 9) (make-block 6 9) (make-block 7 9) (make-block 8 9) (make-block 9 9))))

