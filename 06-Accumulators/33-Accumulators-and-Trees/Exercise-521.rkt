;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-521) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 521.
;; Develop a representation for the states of the missionary-and-cannibal puzzle.
;; Design the function final?,
;; which detects whether in a given state all people are on the right river bank.
;; Design the function render-mc,
;; which maps a state of the missionary-and-cannibal puzzle to an image.


(require 2htdp/image)


;;; Data Definitions

(define MAX 3) ; max number of each actor type.

;; N is a natural number in the interval [0, MAX].

;; A Boat is one of:
;; - 'left
;; - 'right

(define-struct side [mis can])
;; A Side is a structure
;;   (make-side N N)
;; (make-side m c) represents
;; a number of m missionaries and c cannibals on the river bank.

(define-struct ps [left right boat])
;; A PuzzleState is a structure
;;   (make-ps Side Side Boat)
;; (make-ps ls rs b) represents a puzzle state
;; with the left side of the river ls,
;; the right side of the river rs,
;; and the location of the boat b.


;;; Constants

(define SIZE 10)
(define WIDTH (+ (* 2 SIZE) 4))
(define SCENE-HEIGHT (* MAX WIDTH))

(define MIS (overlay (circle SIZE "solid" "brown")
                     (circle (+ 1 SIZE) 'solid 'transparent)))

(define CAN (overlay (circle SIZE "solid" "yellow")
                     (circle (+ 1 SIZE) 'solid 'transparent)))

(define BOAT (above (rhombus SIZE 120 "solid" "blue")
                    (overlay (rectangle (* 2 SIZE) SIZE "solid" "blue")
                             (rectangle (* 3 SIZE) SIZE 'solid 'transparent))))

(define BANK (rectangle (* 2 WIDTH) SCENE-HEIGHT "outline" "green"))

(define RIVER (beside (rectangle 2 SCENE-HEIGHT "solid" "blue")
                      (rectangle (* 5 WIDTH) SCENE-HEIGHT "outline" "blue")
                      (rectangle 2 SCENE-HEIGHT "solid" "blue")))

(define ps-1 (make-ps (make-side 3 3) (make-side 0 0) 'left))
(define ps-2 (make-ps (make-side 2 1) (make-side 1 2) 'right))
(define ps-3 (make-ps (make-side 0 0) (make-side 3 3) 'right))


;;; Functions

;; PuzzleState -> Boolean
;; Determines whether all people are on the right river bank.
(check-expect (final? ps-1) #false)
(check-expect (final? ps-2) #false)
(check-expect (final? ps-3) #true)
(define (final? ps)
  (local ((define left (ps-left ps)))
    (and (zero? (side-mis left)) (zero? (side-can left)))))


;; PuzzleState -> Image
;; Renders an image according to the given puzzle state.
(define (render-mc state)
  (local ((define (render-actor img n)
            (foldr (lambda (i a) (above img a))
                   empty-image
                   (build-list n (lambda (i) i))))

          (define (render-bank bank)
            (overlay (beside (render-actor MIS (side-mis bank))
                             (render-actor CAN (side-can bank)))
                     BANK)))

    (beside (render-bank (ps-left state))
            (overlay/align (ps-boat state) "middle" BOAT RIVER)
            (render-bank (ps-right state)))))


;;; Application

(render-mc ps-1)
(render-mc ps-2)
(render-mc ps-3)

