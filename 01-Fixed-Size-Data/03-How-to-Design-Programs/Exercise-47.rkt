;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-47) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 47.
;; Design a world program that maintains and displays a "happiness gauge."

(require 2htdp/universe)
(require 2htdp/image)

;; Unit Tests
(check-expect (render (* SCORE-MAX 2)) (draw-gauge SCORE-MAX))
(check-expect (render 10) (draw-gauge 10))
(check-expect (render 0) (draw-gauge 0))

(check-expect (tick-handler (* SCORE-MAX 2)) SCORE-MAX)
(check-expect (tick-handler 10.5) 10.4)
(check-expect (tick-handler 0.1) 0)
(check-expect (tick-handler 0) 0)
(check-expect (tick-handler -0.1) 0)

(check-expect (key-handler 15 "down") 18)
(check-expect (key-handler 15 "up") 20)
(check-expect (key-handler 15 "a") 15)

(check-expect (increase-score (* SCORE-MAX 2) 10) SCORE-MAX)
(check-expect (increase-score 10 10) 11)

(check-expect (end? 0) #true)
(check-expect (end? 0.1) #false)

;; Definitions
(define SCORE-MAX 100) ; single point of control over the gauge size.
(define SCORE-MIN 0)
(define SCORE-DECREASE 0.1)
(define SCORE-INCREASE 5) ; 5th part of ws
(define SCORE-BOOST 3) ; 3rd part of ws

(define GAUGE-WIDTH (/ SCORE-MAX 10))
(define GAUGE-HEIGHT SCORE-MAX)

(define FRAME-WIDTH (+ GAUGE-WIDTH 3))
(define FRAME-HEIGHT GAUGE-HEIGHT)

(define SCENE-WIDTH (* FRAME-WIDTH 4))
(define SCENE-HEIGHT (+ FRAME-HEIGHT 1))


;; WorldState -> WorldState
(define (gauge-prog ws)
  (big-bang ws
    [to-draw render]
    [on-tick tick-handler]
    [on-key key-handler]
    [stop-when end?]))


;; WorldState -> Image
(define (render ws)
   (if (> ws SCORE-MAX)
       (draw-gauge SCORE-MAX)
       (draw-gauge ws)))

;; Number -> Image
(define (draw-gauge height)
  (overlay/align/offset
   "middle" "bottom"
   (rectangle GAUGE-WIDTH height "solid" "red")
   0 1
   (overlay/align/offset
    "middle" "bottom"
    (rectangle FRAME-WIDTH FRAME-HEIGHT "outline" "black")
    0 1
    (empty-scene SCENE-WIDTH SCENE-HEIGHT))))


;; WorldState -> WorldState
(define (tick-handler ws)
  (cond
    [(> ws SCORE-MAX) SCORE-MAX]
    [(<= ws SCORE-DECREASE) 0]
    [else (- ws SCORE-DECREASE)]))


;; WorldState -> WorldState
(define (key-handler ws key)
  (cond
    [(key=? key "down") (increase-score ws SCORE-INCREASE)]
    [(key=? key "up") (increase-score ws SCORE-BOOST)]
    [else ws]))

;; WorldState Number -> Number
(define (increase-score ws add)
  (if (> (+ (/ ws add) ws) SCORE-MAX)
      SCORE-MAX
      (+ (/ ws add) ws)))


;; WorldState -> Boolean
(define (end? ws)
  (= ws 0))


;; Application
(gauge-prog 80)

