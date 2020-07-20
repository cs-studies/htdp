;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-71) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 71.
;; Explain the results of the following code with step-by-step computations:

(define HEIGHT 200) ; pixels

(define MIDDLE (quotient HEIGHT 2))
;; ==
;; (define MIDDLE (quotient 200 2))
;; ==
;; (define MIDDLE 100)

(define WIDTH  400) ; pixels

(define CENTER (quotient WIDTH 2))
;; ==
;; (define CENTER (quotient 400 2))
;; ==
;; (define CENTER 200)

(define-struct game [left-player right-player ball])

(define game0
  (make-game MIDDLE MIDDLE (make-posn CENTER CENTER)))
;; ==
;; (define game0
;;   (make-game 100 MIDDLE (make-posn CENTER CENTER)))
;; ==
;; (define game0
;;   (make-game 100 100 (make-posn CENTER CENTER)))
;; ==
;; (define game0
;;   (make-game 100 100 (make-posn 200 CENTER)))
;; ==
;; (define game0
;;   (make-game 100 100 (make-posn 200 200)))

(game-ball game0)
;; ==
;; (game-ball
;;  (make-game 100 100 (make-posn 200 200)))
;; ==
;; (make-posn 200 200)

(posn? (game-ball game0))
;; ==
;; (posn? (game-ball
;;        (make-game 100 100 (make-posn 200 200))))
;; ==
;; (posn? (make-posn 200 200))
;; ==
;; #true

(game-left-player game0)
;; ==
;; (game-left-player (make-game 100 100 (make-posn 200 200)))
;; ==
;; 100

