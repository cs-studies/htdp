;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-63) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 63.
;; Evaluate the following expressions by hand. Show all steps.
;; Assume that sqr performs its computation in a single step.
;; Check the results with DrRacket’s stepper.

(define (distance-to-0 ap)
  (sqrt
   (+ (sqr (posn-x ap))
      (sqr (posn-y ap)))))


;; Expression 1.
(distance-to-0 (make-posn 3 4))

;#| Steps
;; ==
(sqrt
 (+ (sqr (posn-x (make-posn 3 4)))
    (sqr (posn-y (make-posn 3 4)))))

;; ==
(sqrt
 (+ (sqr 3)
    (sqr (posn-y (make-posn 3 4)))))

;; ==
(sqrt
 (+ 9
    (sqr (posn-y (make-posn 3 4)))))

;; ==
(sqrt
 (+ 9
    (sqr 4)))

;; ==
(sqrt
 (+ 9
    16))

;; ==
(sqrt 25)

;; == 5
;|#


;; Expression 2.
(distance-to-0 (make-posn 6 (* 2 4)))

;#| Steps
;; ==
(distance-to-0 (make-posn 6 8))

;; ==
(sqrt
 (+ (sqr (posn-x (make-posn 6 8)))
    (sqr (posn-y (make-posn 6 8)))))

;; ==
(sqrt
 (+ (sqr 6)
    (sqr (posn-y (make-posn 6 8)))))

;; ==
(sqrt
 (+ 36
    (sqr (posn-y (make-posn 6 8)))))

;; ==
(sqrt
 (+ 36
    (sqr 8)))

;; ==
(sqrt
 (+ 36
    64))

;; ==
(sqrt 100)
;; == 10
;|#


;; Expression 3.
(+ (distance-to-0 (make-posn 12 5)) 10)

;#| Steps
;; ==
(+
 (sqrt
  (+ (sqr (posn-x (make-posn 12 5)))
     (sqr (posn-y (make-posn 12 5)))))
 10)

;; ==
(+
 (sqrt
  (+ (sqr 12)
     (sqr (posn-y (make-posn 12 5)))))
 10)

;; ==
(+
 (sqrt
  (+ 144
     (sqr (posn-y (make-posn 12 5)))))
 10)

;; ==
(+
 (sqrt
  (+ 144
     (sqr 5)))
 10)

;; ==
(+
 (sqrt
  (+ 144
     25))
 10)

;; ==
(+
 (sqrt 169)
 10)

;; ==
(+
 13
 10)

;; == 23
;|#

