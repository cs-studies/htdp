;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-482) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 482.
;; Design the place-queens algorithm.
;; Assume you have functions board0, add-queen, find-open-spots.


(require 2htdp/abstraction)


;;; Data Definitions and Constants

(define QUEENS 8)

;; N is one of:
;; - 0
;; - (add1 N)

;; A QP is a structure:
;;   (make-posn CI CI)

;; A CI is an N in [0,QUEENS).
;; interpretation (make-posn r c) denotes the square at
;; the r-th row and c-th column.


;;; Functions

;; Board N -> [Maybe [List-of QP]]
;; Places n queens on board; otherwise, returns #false.
(define (place-queens a-board n)
  (cond
    [(= 0 n) '()]
    [else
     (local ((define (place-queens/backtrace try)
               (cond
                 [(empty? try) #false]
                 [else
                  (local ((define candidate
                            (place-queens (add-queen a-board (first try))
                                          (sub1 n))))
                    (cond
                      [(boolean? candidate)
                       (place-queens/backtrace (rest try))]
                      [else ...]))]))
             (define candidate (place-queens/backtrace a-board)))
       (cond
         [(boolean? candidate) #false]
         [else candidate]))]))

;; N -> Board
;; Creates the initial n by n board.
(define (board0 n) ...)

;; Board QP -> Board
;; Places a queen at qp on a-board.
(define (add-queen a-board qp)
  a-board)

;; Board -> [List-of QP]
;; Finds spots where it is still safe to place a queen.
(define (find-open-spots a-board)
  '())

