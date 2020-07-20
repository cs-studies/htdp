;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname UFO) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)


;; Data Definitions

;; A WorldState is a Number.
;; Represents the number of pixels between the top and the UFO.
;; Falls into one of three intervals:
;; – between 0 and CLOSE
;; – between CLOSE and LAND
;; – below LAND


;; Constants Definitions

(define WIDTH 300) ; distances in terms of pixels
(define HEIGHT 100)
(define MTSCN (empty-scene WIDTH HEIGHT))

(define UFO-HEIGHT 20)
(define UFO-WIDTH (* 2 UFO-HEIGHT))
(define UFO (overlay
             (circle (/ UFO-HEIGHT 2) "solid" "green")
             (ellipse UFO-WIDTH (/ UFO-HEIGHT 2) "solid" "green")))
(define UFO-X (/ WIDTH 2))
(define UFO-VELOCITY 3)

(define CLOSE (/ HEIGHT 3))
(define LAND (- HEIGHT (/ UFO-HEIGHT 2)))

(define STATUS-X 20)
(define STATUS-Y 20)
(define STATUS-FONT-SIZE 11)


;; Functions Definitions

;; WorldState -> WorldState
(define (main y0)
  (big-bang y0
    [on-tick next-y]
    [to-draw render]
    [stop-when end?]))

;; WorldState -> WorldState
(check-expect (next-y 11) 14)
(define (next-y y)
  (+ y UFO-VELOCITY))

;; WorldState -> Image
(check-expect (render 10) (render 10))
(define (render y)
  (place-image (render/status y) STATUS-X STATUS-Y (render/ufo y)))

;; WorldState -> Image
(check-expect (render/status 1) (text "descending" STATUS-FONT-SIZE "green"))
(check-expect (render/status (+ CLOSE 1)) (text "closing in" STATUS-FONT-SIZE "orange"))
(check-expect (render/status LAND) (text "landed" STATUS-FONT-SIZE "red"))
(define (render/status y)
  (cond
    [(<= 0 y CLOSE)
     (text "descending" STATUS-FONT-SIZE "green")]
    [(< CLOSE y LAND)
     (text "closing in" STATUS-FONT-SIZE "orange")]
    [(>= y LAND)
     (text "landed" STATUS-FONT-SIZE "red")]))

;; WorldState -> Image
(check-expect (render/ufo 11) (place-image UFO UFO-X 11 MTSCN))
(define (render/ufo y)
  (place-image UFO UFO-X y MTSCN))

;; WorldState -> Boolean
(check-expect (end? (+ LAND 1)) #true)
(check-expect (end? LAND) #false)
(check-expect (end? (- LAND 1)) #false)
(define (end? y)
  (> y LAND))

;; Application
;; (main 0)
