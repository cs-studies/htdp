;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-103) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 103.
;; Develop a data representation for the following four kinds of zoo animals:
;; - spiders
;; - elephants
;; - boa constrictors
;; - armadillos
;;
;; Develop a template for functions that consume zoo animals.
;;
;; Design the fits? function, which consumes a zoo animal and a description of a cage.
;; It determines whether the cage’s volume is large enough for the animal.


;;; Data Definitions

;; A Parameter is one of:
;; - a Number greater than or equal to 0
;; - #false

(define-struct animal [legs volume length girth])
;; An Animal is a structure:
;;   (make-animal Parameter Parameter Parameter Parameter)
;; (make-animal l v len g) represents an animal with
;; - l number of legs
;; - v volume of a required cage
;; - len length of an animal
;; - g girth of an animal


(define (consume animal)
  (... (animal-legs animal) ...
   ... (animal-volume animal) ...
   ... (animal-length animal) ...
   ... (animal-girth animal) ...))

(define (fits? animal cage)
  (if (boolean? (animal-volume animal))
      (... (animal-length animal) ...
       ... (animal-girth animal) ...)
      (... (animal-volume animal) ...)))



