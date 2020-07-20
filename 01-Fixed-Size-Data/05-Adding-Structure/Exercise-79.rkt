;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-79) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 79.
;; Create examples for the following data definitions:


;;; Data Definition 1

;; A Color is one of:
;; — "white"
;; — "yellow"
;; — "orange"
;; — "green"
;; — "red"
;; — "blue"
;; — "black"

(define WHITE "white")
(define LOG-CRITICAL "red")


;;; Data Definition 2

;; H is a Number between 0 and 100.
;; interpretation represents a happiness value

(define MAX 100)
(define MIN 0)
(define MID 50)


;;; Data Definition 3

(define-struct person [fstname lstname male?])
;; A Person is a structure:
;;   (make-person String String Boolean)

(define turing (make-person "Alan" "Turing" #true))

(person-fstname turing)
(person-lstname turing)
(person-male? turing)

;; In this case a more abstract field name,
;; such as 'sex', would be more usable in the modern world,
;; accepting enumerated values for female, intersex, male.
;; As for a 'predicate' type of a field name,
;; it seems as a potentially handy convention
;; for all binary [yes/no] definitions.


;;; Data Definition 4

(define-struct dog [owner name age happiness])
;; A Dog is a structure:
;;   (make-dog Person String PositiveInteger H)

(define puppy (make-dog turing "Puppy" 2 MAX))

(dog-owner puppy)
(person-lstname (dog-owner puppy))
(dog-name puppy)
(dog-age puppy)
(dog-happiness puppy)

;; Interpretation
;; (make-dog o n a h) represents a dog
;; - belonging to an owner represented by a Person o,
;; - with a name n,
;; - of an age a,
;; - with a hapiness level h.


;;; Data Definition 4

;; A Weapon is one of:
;; — #false
;; — Posn
;; interpretation #false means the missile hasn't
;; been fired yet; a Posn means it is in flight.

(define NUCLEAR #false)
(define TARGET (make-posn 50 40))

