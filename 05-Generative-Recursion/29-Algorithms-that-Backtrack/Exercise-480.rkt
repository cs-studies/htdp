;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-480) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 480.
;; Design render-queens.
;; The function consumes a natural number n, a list of QPs, and an Image.
;; It produces an image of an n by n chess board
;; with the given image placed according to the given QPs.


(require 2htdp/image)


(define QUEENS 8)

;; N is one of:
;; - 0
;; - (add1 N)

;; A QP is a structure:
;;   (make-posn CI CI)

;; A CI is an N in [0,QUEENS).
;; interpretation (make-posn r c) denotes the square at
;; the r-th row and c-th column.


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

