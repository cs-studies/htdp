;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-113) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 113.
;; Design predicates for the data definitions from the preceding section.


;;; SIGS

; A UFO is a Posn.
; interpretation (make-posn x y) is the UFO's location
; (using the top-down, left-to-right convention)

(define-struct tank [loc vel])
; A Tank is a structure:
;   (make-tank Number Number).
; interpretation (make-tank x dx) specifies the position:
; (x, HEIGHT) and the tank's speed: dx pixels/tick

; A Missile is a Posn.
; interpretation (make-posn x y) is the missile's place

(define-struct aim [ufo tank])
(define-struct fired [ufo tank missile])

; A SIGS is one of:
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the complete state of a
; space invader game

;; Any -> Boolean
;; Checks that v is an element of the SIGS collection.
(check-expect (sigs? (make-aim (make-posn 10 20) (make-tank 5 7))) #true)
(check-expect (sigs? (make-fired (make-posn 10 20) (make-tank 5 7) (make-posn 2 3))) #true)
(check-expect (sigs? 1) #false)
(check-expect (sigs? #true) #false)
(check-expect (sigs? (make-posn 22 33)) #false)
(define (sigs? v)
  (or (aim? v) (fired? v)))


;;; Coordinate

; A Coordinate is one of:
; – a NegativeNumber
; interpretation on the y axis, distance from top
; – a PositiveNumber
; interpretation on the x axis, distance from left
; – a Posn
; interpretation an ordinary Cartesian point

;; Any -> Boolean
;; Check that v is an element of the Coordinate collection.
(check-expect (coordinate? -1) #true)
(check-expect (coordinate? 0) #false) ; PositiveNumber is greater than 0 throughout the book.
(check-expect (coordinate? 1) #true)
(check-expect (coordinate? (make-posn 2 3)) #true)
(check-expect (coordinate? (make-tank 20 30)) #false)
(define (coordinate? v)
  (or (posn? v) (and (number? v) (not (= 0 v)))))


;;; VAnimal

(define-struct vCat [x score])
;; A VCat is a structure:
;; (make-vCat Number Score)
;; (make-vCat x s) represents a walking cat
;; which is located on an x-coordinate x and
;; has a happiness level s.

(define-struct vCham [x color score])
;; A VCham is a structure:
;; (make-vCham Number Color Score)
;; (make-vCham x c s) represents a walking cham
;; which is located on an x-coordinate x,
;; has a color c, and
;; a happiness level s.

; A VAnimal is either
; – a VCat
; – a VCham

;; Any -> Boolean
;; Check that v is an element of the VAnimal collection.
(check-expect (vAnimal? (make-vCat 300 60)) #true)
(check-expect (vAnimal? (make-vCham 200 "blue" 77)) #true)
(check-expect (vAnimal? 1) #false)
(check-expect (vAnimal? "a") #false)
(check-expect (vAnimal? (make-posn 2 3)) #false)
(define (vAnimal? v)
  (or (vCat? v) (vCham? v)))

