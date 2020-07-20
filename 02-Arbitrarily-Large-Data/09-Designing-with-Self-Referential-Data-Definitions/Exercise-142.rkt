;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-142) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 142.
;; Design the ill-sized? function,
;; which consumes a list of images loi and a positive number n.
;; It produces the first image on loi that is not an n by n square;
;; if it cannot find such an image, it produces #false.


(require 2htdp/image)

;; A List-of-images is one of:
;; - '()
;; - (cons Image List-of-images)

;; ImageOrFalse is one of:
;; – Image
;; – #false

;; PositiveNumber is a Number greater than zero.

(define SQUARE (square 20 "solid" "red"))
(define STAR (star 10 "solid" "yellow"))

;; List-of-images PositiveNumber -> ImageOrFalse
;; Produces the first image on the list l
;; that is not an n by b square.
(check-expect (ill-sized? '() 20) #false)
(check-expect (ill-sized? (cons SQUARE '()) 20) #false)
(check-expect (ill-sized? (cons SQUARE (cons SQUARE '())) 20) #false)
(check-expect (ill-sized? (cons STAR '()) 20) STAR)
(check-expect (ill-sized? (cons SQUARE (cons STAR '())) 20) STAR)
(check-expect (ill-sized? (cons STAR (cons SQUARE '())) 20) STAR)
#|
;; Template
(define (ill-sized? l n)
  (cond
    [(empty? l) ...]
    [else (... (first l) ... (ill-sized? (rest l) n) ...)]))
|#
(define (ill-sized? l n)
  (cond
    [(empty? l) #false]
    [(and (= n (image-height (first l))) (= n (image-width (first l))))
     (ill-sized? (rest l) n)]
    [else (first l)]))

