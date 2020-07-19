;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-313) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 312.
;; Develop the function eye-colors,
;; which consumes a family tree
;; and produces a list of all eye colors in the tree.
;; An eye color may occur more than once in the resulting list.


;;; Data Definitions

(define-struct child [father mother name date eyes])
;; A Child is a structure:
;;   (make-child Child Child String N String)

(define-struct no-parent [])
(define NP (make-no-parent))

;; An FT (Family Tree) is one of:
;; – NP
;; – (make-child FT FT String N String)


;;; Constants

;; Oldest Generation
(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))

;; Middle Generation
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))

;; Youngest Generation
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))


;;; Functions

;; FT -> Boolean
;; Determines whether an ancestor has blue eyes.
(check-expect (blue-eyed-ancestor? Eva) #false)
(check-expect (blue-eyed-ancestor? Gustav) #true)
(define (blue-eyed-ancestor? an-ftree)
  (cond
    [(no-parent? an-ftree) #false]
    [else (or (blue-eyed? (child-father an-ftree))
              (blue-eyed? (child-mother an-ftree))
              (blue-eyed-ancestor? (child-father an-ftree))
              (blue-eyed-ancestor? (child-mother an-ftree)))]))

;; Any -> Boolean
;; Determines whether the child is given
;; and the child's eyes color is blue.
(define (blue-eyed? any)
  (and (child? any) (string=? "blue" (child-eyes any))))


;; A friend's solution never checks an eye color,
;; just traverses the family tree down to the no-parent element
;; and returns #false.

