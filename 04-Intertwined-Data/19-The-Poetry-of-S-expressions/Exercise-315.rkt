;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-315) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 315.
;; Develop the function average-age.
;; It consumes a family tree and a year (N).
;; It produces the average age
;; of all child instances in the forest.


(require 2htdp/abstraction)


;;; Data Definitions

(define-struct child [father mother name date eyes])
;; A Child is a structure:
;;   (make-child Child Child String N String)

(define-struct no-parent [])
(define NP (make-no-parent))

;; An FT (Family Tree) is one of:
;; – NP
;; – (make-child FT FT String N String)

;; An FF (Family Forest) is a [List-of FT].
;; Represents several families and their ancestor trees.


;;; Constants

(define Carl (make-child NP NP "Carl" 1926 "green"))
(define Bettina (make-child NP NP "Bettina" 1926 "green"))
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child NP NP "Fred" 1966 "pink"))
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Gustav Adam))


;;; Functions

;; [List-of FT] Number -> Number
;; Produces the average age
;; of all child structures in the family tree.
(check-expect (average-age ff1 2020) 94)
(check-expect (average-age ff2 2020) 74.25)
(check-expect (average-age ff3 2020) 73.375)
(define (average-age a-forest year)
  (local (
          (define (sum-ages an-ftree)
            (cond
              [(no-parent? an-ftree) 0]
              [else (+ (- year (child-date an-ftree))
                       (sum-ages (child-father an-ftree))
                       (sum-ages (child-mother an-ftree)))]))

          (define (count-persons an-ftree)
            (cond
              [(no-parent? an-ftree) 0]
              [else (+ 1
                       (count-persons (child-father an-ftree))
                       (count-persons (child-mother an-ftree)))])))

    (/
     (for/sum ([ft a-forest]) (sum-ages ft))
     (for/sum ([ft a-forest]) (count-persons ft)))))

