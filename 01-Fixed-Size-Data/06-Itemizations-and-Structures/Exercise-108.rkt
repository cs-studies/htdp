;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-108) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 108.
;; Design a world program that implements a pedestrian traffic light.


(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions and Constants

(define STOP 0)
(define WALK 1)
(define PREPARE 2)

;; A Light is one of:
;; - STOP
;; - WALK
;; - PREPARE
;; Represents the state of the traffic light.

;; A Timer is one of:
;; - Number
;; - #false
;; Represents a number of seconds
;; before switching to the next traffic light state.

(define-struct tl [light timer])
;; A TL (Traffic Light)  is a structure:
;;   (make-tl Light Timer)
;; (make-tl l t) represents a traffic light with
;; the light l enabled and
;; the number of seconds t till the next traffic light state switch.

;; A KeyEvent is a " ".
;; Represents a pressed space key.


;;; Constants

(define WIDTH 150)
(define HEIGHT 150)
(define BACKGROUND (empty-scene WIDTH HEIGHT "LemonChiffon"))

(define STOP-IMAGE (bitmap "./images/stop.png"))
(define WALK-IMAGE (bitmap "./images/walk.png"))

(define TIMER-MAX 10) ; seconds

(define PREPARE-SIZE 50)
(define PREPARE-COLOR-1 "orange")
(define PREPARE-COLOR-2 "green")

(define INIT-STATE (make-tl STOP #false))


;;; Functions

;; TL -> TL
;; Usage: (traffic-light INIT-STATE)
(define (traffic-light tls)
  (big-bang tls
    [to-draw render]
    [on-tick tick-handler 1] ; tick once per second.
    [on-key key-handler]))

;; TL -> Image
;; Renders a traffic light image.
(check-expect (render INIT-STATE) (overlay STOP-IMAGE BACKGROUND))
(check-expect (render (make-tl WALK 5)) (overlay WALK-IMAGE BACKGROUND))
(check-expect (render (make-tl PREPARE 5))
              (overlay (text "4" PREPARE-SIZE PREPARE-COLOR-2) BACKGROUND))
(check-expect (render (make-tl PREPARE 4))
              (overlay (text "3" PREPARE-SIZE PREPARE-COLOR-1) BACKGROUND))
(define (render tls)
  (overlay
   (cond
     [(= STOP (tl-light tls)) STOP-IMAGE]
     [(= WALK (tl-light tls)) WALK-IMAGE]
     [(= PREPARE (tl-light tls))
      (text (number->string (- (tl-timer tls) 1))
            PREPARE-SIZE
            (if (= 0 (modulo (tl-timer tls) 2)) PREPARE-COLOR-1 PREPARE-COLOR-2))])
   BACKGROUND))

;; TL -> TL
;; Switches the traffic light to the next light
;; according to the timer.
(check-expect (tick-handler INIT-STATE) INIT-STATE)
(check-expect (tick-handler (make-tl WALK 5)) (make-tl WALK 4))
(check-expect (tick-handler (make-tl WALK 1)) (make-tl PREPARE 10))
(check-expect (tick-handler (make-tl PREPARE 10)) (make-tl PREPARE 9))
(check-expect (tick-handler (make-tl PREPARE 1)) INIT-STATE)
(define (tick-handler tls)
  (if (= STOP (tl-light tls))
      tls
      (cond
        [(> (tl-timer tls) 1)
         (make-tl (tl-light tls) (- (tl-timer tls) 1))]
        [(= WALK (tl-light tls))
         (make-tl PREPARE TIMER-MAX)]
        [(= PREPARE (tl-light tls))
         (make-tl STOP #false)])))

;; TL KeyEvent -> TL
;; Switches the traffic light from its default state
;; on a space key press.
(check-expect (key-handler INIT-STATE "a") INIT-STATE)
(check-expect (key-handler INIT-STATE " ") (make-tl WALK TIMER-MAX))
(check-expect (key-handler (make-tl WALK 5) " ") (make-tl WALK 5))
(check-expect (key-handler (make-tl PREPARE 5) " ") (make-tl PREPARE 5))
(define (key-handler tls key)
  (if (and (= (tl-light tls) STOP) (key=? " " key))
      (make-tl WALK TIMER-MAX)
      tls))


;;; Application

;; (traffic-light INIT-STATE)

