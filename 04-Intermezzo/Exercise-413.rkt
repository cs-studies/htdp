;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-413) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 413.
;; Design inex*.
;; The function multiplies two Inex representations of numbers,
;; including inputs that force an additional increase of the output’s exponent.
;; Like inex+, it must signal its own error if the result is out of range,
;; not rely on create-inex to perform error checking.


;; N is one of:
;; - 0
;; - (add1 N)

;; An N99 is an N between 0 and 99 (inclusive).

;; An S is one of:
;; – 1
;; – -1

(define-struct inex [mantissa sign exponent])
;; An Inex is a structure:
;;   (make-inex N99 S N99)

(define ERR-RANGE "The result is out of Inex range.")

;; Inex -> Number
;; Converts an inex into its numeric equivalent.
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
      10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

;; N Number N -> Inex
;; Makes an instance of Inex after checking the arguments.
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))

(define MAX-POSITIVE (create-inex 99 1 99))
(define MIN-POSITIVE (create-inex 1 -1 99))

;; Inex Inex -> Inex
;; Adds two Inex representations of numbers
;; that have the same exponent.
(check-expect (inex* (create-inex 2 1 4) (create-inex 8 1 10))
              (create-inex 16 1 14))
(check-expect (inex* (create-inex 20 1 1) (create-inex 5 1 4))
              (create-inex 10 1 6))
(check-expect (inex* (create-inex 27 -1 1) (create-inex 7 1 4))
              (create-inex 19 1 4))
(define (inex* i1 i2)
  (number->inex (* (inex-mantissa i1)
                   (inex-mantissa i2)
                   (expt 10 (+ (* (inex-exponent i1) (inex-sign i1))
                               (* (inex-exponent i2) (inex-sign i2)))))))

;; Number -> Inex
;; Converts a number into its inex representation.
(check-error (number->inex -1) ERR-RANGE)
(check-error (number->inex -12) ERR-RANGE)
(check-error (number->inex 0) ERR-RANGE)
(check-expect (number->inex 1) (create-inex 1 1 0))
(check-expect (number->inex 10) (create-inex 10 1 0))
(check-expect (number->inex 1000) (create-inex 10 1 2))
(check-expect (number->inex 2000) (create-inex 20 1 2))
(check-expect (number->inex 0.1) (create-inex 1 -1 1))
(check-expect (number->inex 0.01) (create-inex 1 -1 2))
(check-expect (number->inex 0.002) (create-inex 2 -1 3))
(check-expect (number->inex 0.12) (create-inex 12 -1 2))
(check-expect (number->inex 1.05) (create-inex 10 -1 1))
(check-expect (number->inex 1.2) (create-inex 12 -1 1))
(check-expect (number->inex 1.35) (create-inex 14 -1 1))
(check-expect (number->inex 1.74) (create-inex 17 -1 1))
(check-expect (number->inex 1.75) (create-inex 18 -1 1))
(check-expect (number->inex 10.05) (create-inex 10 1 0))
(check-expect (number->inex 10.2) (create-inex 10 1 0))
(check-expect (number->inex 10.25) (create-inex 10 1 0))
(check-expect (number->inex 10.74) (create-inex 11 1 0))
(check-expect (number->inex 10.75) (create-inex 11 1 0))
(define (number->inex n)
  (local ((define (convert m s e)
            (if (not (and (<= 0 e 99) (or (= s 1) (= s -1))))
                (error ERR-RANGE)
                (cond
                  [(and (integer? m) (<= 1 m 99)) (make-inex m s e)]
                  [else (convert (if (= 1 s)
                                     (round (/ m 10))
                                     (* m 10))
                                 s
                                 (add1 e))]))))
    (if (or (> n (inex->number MAX-POSITIVE))
            (< n (inex->number MIN-POSITIVE)))
        (error ERR-RANGE)
        (cond
          [(or (integer? n) (> (round n) 9)) (convert (round n) 1 0)]
          [(< n 1) (convert n -1 0)]
          [else (convert (round (* 10 n)) -1 1)]))))

