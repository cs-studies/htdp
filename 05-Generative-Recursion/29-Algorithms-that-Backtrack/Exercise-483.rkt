;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-483) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 483.
;; Develop a data definition for Board
;; and design the three functions specified in exercise 482.


(require 2htdp/abstraction)
(require 2htdp/image)


;;; Data Definitions

;; A Board is a [List-of QP].
;; Contains positions on which queens can be placed.

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
(check-expect (place-queens (board0 2) 2) #false)
(check-expect (place-queens (board0 3) 3) #false)
(check-satisfied (place-queens (board0 4) 4) (n-queens-solution? 4))
(check-satisfied (place-queens (board0 8) 8) (n-queens-solution? 8))
(define (place-queens a-board n)
  (cond
    [(= 0 n) '()]
    [else
     (local ((define (place-queens/backtrace try)
               (cond
                 [(empty? try) #false]
                 [else
                  (local ((define qp (first try))
                          (define place-other-queens
                            (place-queens (add-queen a-board qp)
                                          (sub1 n))))
                    (cond
                      [(boolean? place-other-queens)
                       (place-queens/backtrace (rest try))]
                      [else (cons qp place-other-queens)]))]))

             (define candidate (place-queens/backtrace a-board)))
       (cond
         [(boolean? candidate) #false]
         [else candidate]))]))

;; N -> Board
;; Creates the initial n by n board.
(define (board0 n)
  (for*/list ([i n] [j n]) (make-posn i j)))

;; Board QP -> Board
;; Places a queen at qp on a-board.
(check-expect (add-queen (board0 2) (make-posn 0 1)) '())
(check-expect (add-queen (board0 3) (make-posn 0 0))
              (list (make-posn 1 2) (make-posn 2 1)))
(check-expect (add-queen (board0 4) (make-posn 2 2))
              (list (make-posn 0 1) (make-posn 0 3) (make-posn 1 0) (make-posn 3 0)))
(define (add-queen a-board qp)
  (filter (lambda (p) (not (threatening? qp p))) a-board))


;; QP QP -> Boolean
;; Determines whether queens threaten each other.
(check-expect (threatening? (make-posn 0 0) (make-posn 1 2)) #false)
(check-expect (threatening? (make-posn 2 3) (make-posn 5 5)) #false)
(check-expect (threatening? (make-posn 2 3) (make-posn 2 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 6 3)) #true)
(check-expect (threatening? (make-posn 2 3) (make-posn 1 2)) #true)
(define (threatening? q1 q2)
  (local ((define q1x (posn-x q1))
          (define q1y (posn-y q1))
          (define q2x (posn-x q2))
          (define q2y (posn-y q2)))
    (or (= q1x q2x)
        (= q1y q2y)
        (= (+ q1x q1y) (+ q2x q2y))
        (= (- q1x q1y) (- q2x q2y)))))

;; N -> [[List-of QP] -> Boolean]
;; Produces a predicate that determines whether
;; a given list of QP is a solution to an n-queens puzzle.
(define (n-queens-solution? n)
  (lambda (lop)
    (if (not (= (length lop) n))
        #false
        (foldr (lambda (q1 checked)
                 (local ((define q1-vs-qs
                           (andmap
                            (lambda (q2) (not (threatening? q1 q2)))
                            (remove q1 lop))))
                   (and q1-vs-qs checked)))
               #true
               lop))))


;;; Rendering

(define QUEEN-IMG  (overlay/offset
                    (right-triangle 8 16 "solid" "red")
                    6 0
                    (overlay/offset
                     (triangle 20 "solid" "red")
                     6 0
                     (flip-horizontal (right-triangle 8 16 "solid" "red")))))

(define SQUARE-SIZE (+ 4 (image-width QUEEN-IMG)))

(define SQUARE (square SQUARE-SIZE "outline" "black"))

(define OFFSET (/ SQUARE-SIZE 2))

;; N QP Image -> Image
;; Produces an image of an n by n chess board with the queens.
(check-expect (render-queens 3 '() QUEEN-IMG) (draw-board 3 3))
(check-expect (render-queens 4 (list (make-posn 2 3)) QUEEN-IMG)
              (place-image QUEEN-IMG
                           (+ (* SQUARE-SIZE 2) OFFSET)
                           (+ (* SQUARE-SIZE 3) OFFSET)
                           (draw-board 4 4)))
(define (render-queens n lop img)
  (cond
    [(empty? lop) (draw-board n n)]
    [else
     (local ((define qp (first lop)))
       (place-image img
                    (+ (* SQUARE-SIZE (posn-x qp)) OFFSET)
                    (+ (* SQUARE-SIZE (posn-y qp)) OFFSET)
                    (render-queens n (rest lop) img)))]))

;; N N -> Image
;; Renders an image of an c by r chess board.
(define (draw-board c r)
  (local ((define (col n img)
            (cond
              [(zero? n) empty-image]
              [else (beside img (col (sub1 n) img))]))
          (define (row n img)
            (cond
              [(zero? n) empty-image]
              [else (above img (row (sub1 n) img))])))
    (place-image
     (row r (col c SQUARE))
     (/ (* SQUARE-SIZE c) 2) (/ (* SQUARE-SIZE r) 2)
     (empty-scene (+ 1 (* SQUARE-SIZE c)) (+ 1 (* SQUARE-SIZE r)) "white"))))


;;; Application

(render-queens QUEENS
               (place-queens (board0 QUEENS) QUEENS)
               QUEEN-IMG)

