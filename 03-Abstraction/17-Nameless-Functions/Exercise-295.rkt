;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-295) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 295.
;; Develop n-inside-playground?, a specification of the given function random-posns.
;; The function generates a predicate that ensures
;; that the length of the given list is some given count
;; and that all Posns in this list are within a WIDTH by HEIGHT rectangle.
;; Define random-posns/bad that satisfies n-inside-playground?
;; and does not live up to the expectations implied by the above purpose statement.


;; Distances in terms of pixels.
(define WIDTH 300)
(define HEIGHT 300)

;; N -> [List-of Posn]
;; Generates n random Posns in [0,WIDTH) by [0,HEIGHT).
(check-satisfied (random-posns 3) (n-inside-playground? 3))
(check-satisfied (random-posns 10) (n-inside-playground? 10))
(define (random-posns n)
  (build-list
   n
   (lambda (i)
     (make-posn (random WIDTH) (random HEIGHT)))))

;; N -> [[List-of Posn] -> Boolean]
(define (n-inside-playground? n)
  (lambda (l0)
    (local (;; Posn -> Boolean
            (define (valid-posn? p)
              (local (;; N N N -> Boolean
                      (define (in-range? k start end)
                        (and (>= k start) (< k end))))
                (and (in-range? (posn-x p) 0 WIDTH)
                     (in-range? (posn-y p) 0 HEIGHT)))))
      (and (= (length l0) n) (andmap valid-posn? l0)))))


;; N -> [List-of Posn]
;; Generates n NOT random Posns in [0,WIDTH) by [0,HEIGHT).
(check-satisfied (random-posns/bad 3) (n-inside-playground? 3))
(define (random-posns/bad n)
  (make-list n (make-posn (- WIDTH 1) (- HEIGHT 1))))

