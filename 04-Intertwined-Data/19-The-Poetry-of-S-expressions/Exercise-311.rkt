;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-311) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 311.
;; Develop the function average-age.
;; It consumes a family tree and the current year.
;; It produces the average age
;; of all child structures in the family tree.


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

;; FT Number -> Number
;; Produces the average age
;; of all child structures in the family tree.
(check-expect (average-age NP 2020) 0)
(check-expect (average-age Carl 2020) 94)
(check-expect (average-age Carl 2015) 89)
(check-expect (average-age Gustav 2020) 65.8)
(check-expect (average-age Gustav 2015) 60.8)
(define (average-age an-ftree year)
  (local (;; FT -> Number
          (define (count-persons an-ftree)
            (cond
              [(no-parent? an-ftree) 0]
              [else (+ 1
                       (count-persons (child-father an-ftree))
                       (count-persons (child-mother an-ftree)))]))
          ;; FT Number -> Number
          (define (sum-ages an-ftree)
            (cond
              [(no-parent? an-ftree) 0]
              [else (+ (- year (child-date an-ftree))
                       (sum-ages (child-father an-ftree))
                       (sum-ages (child-mother an-ftree)))])))
    (cond
      [(no-parent? an-ftree) 0]
      [else (/
             (sum-ages an-ftree)
             (count-persons an-ftree))])))

