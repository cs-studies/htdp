;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-412) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 412.
;; Design inex+.
;; The function adds two Inex representations of numbers that have the same exponent.
;; The function must be able to deal with inputs that increase the exponent.
;; Furthermore, it must signal its own error if the result is out of range,
;; not rely on create-inex for error checking.
;; Challenge:
;; Extend inex+ so that it can deal with inputs whose exponents differ by 1.


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

;; N Number N -> Inex
;; Makes an instance of Inex after checking the arguments.
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else (error "bad values given")]))

;; Inex -> Number
;; Converts an inex into its numeric equivalent.
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt
      10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

(define MAX-POSITIVE (create-inex 99 1 99))
(define MIN-POSITIVE (create-inex 1 -1 99))

(define ERR-EXPONENTS "Exponents mismatch.")
(define ERR-RANGE "The result is out of Inex range.")

;; Inex Inex -> Inex
;; Adds two Inex representations of numbers
;; that have the same exponent.
(check-expect (inex+ (create-inex 1 1 0) (create-inex 2 1 0))
              (create-inex 3 1 0))
(check-expect (inex+ (create-inex 55 1 0) (create-inex 55 1 0))
              (create-inex 11 1 1))
(check-expect (inex+ (create-inex 56 1 0) (create-inex 56 1 0))
              (create-inex 11 1 1))
(check-expect (inex+ (create-inex 1 -1 0) (create-inex 2 -1 0))
              (create-inex 3 -1 0)) ; 3
(check-expect (inex+ (create-inex 1 -1 1) (create-inex 2 -1 1))
              (create-inex 3 -1 1)) ; 0.3
(check-expect (inex+ (create-inex 1 -1 2) (create-inex 2 -1 2))
              (create-inex 3 -1 2)) ; 0.03
(check-expect (inex+ (create-inex 55 -1 1) (create-inex 55 -1 1))
              (create-inex 11 -1 0))
(check-error (inex+ (create-inex 1 1 0) (create-inex 1 1 1))
             ERR-EXPONENTS)
(check-error (inex+ (create-inex 1 1 0) (create-inex 1 -1 0))
             ERR-EXPONENTS)
(check-error (inex+ (create-inex 99 1 99) (create-inex 1 1 99))
             ERR-RANGE)
(check-error (inex+ (create-inex 55 -1 0) (create-inex 55 -1 0))
             ERR-RANGE)
(check-error (inex+ (create-inex 99 -1 0) (create-inex 1 -1 0))
             ERR-RANGE)
(define (inex+ i1 i2)
  (local (
          (define same-exponents
            (and (= (inex-sign i1) (inex-sign i2))
                 (= (inex-exponent i1) (inex-exponent i2))))

          (define i-sign (inex-sign i1))

          (define i-exp (inex-exponent i1))

          (define mantissa-sum (+ (inex-mantissa i1) (inex-mantissa i2)))

          (define (closest mantissa)
            (local ((define new-mantissa (round (/ mantissa 10)))
                    (define negative-sign? (= -1 i-sign)))
              (cond
                [negative-sign?
                 (local ((define new-exp (- i-exp 1)))
                   (if (< new-exp 0)
                       (error ERR-RANGE)
                       (make-inex new-mantissa i-sign new-exp)))]
                [else
                 (local ((define new-exp (+ i-exp 1)))
                   (if (> new-exp 99)
                       (error ERR-RANGE)
                       (make-inex new-mantissa i-sign new-exp)))]))))
    (if same-exponents
        (if (> mantissa-sum 99)
            (closest mantissa-sum)
            (make-inex mantissa-sum i-sign i-exp))
        (error ERR-EXPONENTS))))


;; Inex Inex -> Inex
;; Adds two Inex representations of numbers
;; whose exponents are NOT the same.
(check-expect (inex2+ (create-inex 1 1 0) (create-inex 2 1 0))
              (create-inex 3 1 0))
(check-expect (inex2+ (create-inex 55 1 0) (create-inex 55 1 0))
              (create-inex 11 1 1))
(check-expect (inex2+ (create-inex 56 1 0) (create-inex 56 1 0))
              (create-inex 11 1 1))
(check-expect (inex2+ (create-inex 1 -1 0) (create-inex 2 -1 0))
              (create-inex 3 1 0)) ; 3
(check-expect (inex2+ (create-inex 1 -1 1) (create-inex 2 -1 1))
              (create-inex 3 -1 1)) ; 0.3
(check-expect (inex2+ (create-inex 1 -1 2) (create-inex 2 -1 2))
              (create-inex 3 -1 2)) ; 0.03
(check-expect (inex2+ (create-inex 55 -1 0) (create-inex 55 -1 0))
              (create-inex 11 1 1))
(check-expect (inex2+ (create-inex 55 -1 1) (create-inex 55 -1 1))
              (create-inex 11 1 0))
(check-error (inex2+ (create-inex 1 1 0) (create-inex 1 1 2))
             ERR-EXPONENTS)
(check-error (inex2+ (create-inex 99 1 99) (create-inex 1 1 99))
             ERR-RANGE)
(check-expect (inex2+ (create-inex 1 1 0) (create-inex 2 1 1))
              (create-inex 21 1 0))
(check-expect (inex2+ (create-inex 1 1 1) (create-inex 2 1 0))
              (create-inex 12 1 0))
(check-expect (inex2+ (create-inex 44 1 0) (create-inex 25 1 1))
              (create-inex 29 1 1))
(check-expect (inex2+ (create-inex 45 1 0) (create-inex 25 1 1))
              (create-inex 30 1 1))
(check-expect (inex2+ (create-inex 1 -1 0) (create-inex 2 -1 1))
              (create-inex 12 -1 1)) ; 1+0.2=1.2
(check-expect (inex2+ (create-inex 1 -1 1) (create-inex 2 -1 2))
              (create-inex 12 -1 2)) ; 0.1+0.02=0.12
(check-expect (inex2+ (create-inex 45 -1 1) (create-inex 24 -1 2))
              (create-inex 47 -1 1))
(check-expect (inex2+ (create-inex 45 -1 1) (create-inex 25 -1 2))
              (create-inex 48 -1 1)) ; 4.5+0.25=4.75=~4.8
(check-expect (inex2+ (create-inex 1 1 0) (create-inex 1 -1 0))
              (create-inex 2 1 0))
(check-expect (inex2+ (create-inex 99 -1 0) (create-inex 1 -1 0))
              (create-inex 10 1 1))
(define (inex2+ i1 i2)
  (local ((define valid-exponents
            (or (= (inex-exponent i1) (inex-exponent i2))
                (= 1 (abs (- (inex-exponent i1) (inex-exponent i2)))))))
    (if valid-exponents
        (number->inex (+ (inex->number i1)
                         (inex->number i2)))
        (error ERR-EXPONENTS))))

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
  (if (or (> n (inex->number MAX-POSITIVE))
          (< n (inex->number MIN-POSITIVE)))
      (error ERR-RANGE)
      (cond
        [(or (integer? n) (> (round n) 9)) (convert (round n) 1 0)]
        [(< n 1) (convert n -1 0)]
        [else (convert (round (* 10 n)) -1 1)])))

;; Number S N -> Inex
;; Converts the given inex fields values
;; into the corresponding inex representation.
(check-error (convert 1 0 0) ERR-RANGE)
(check-error (convert 1 2 0) ERR-RANGE)
(check-error (convert 1 1 -1) ERR-RANGE)
(check-error (convert 1 1 100) ERR-RANGE)
(check-expect (convert 1 1 0) (make-inex 1 1 0))
(check-expect (convert 1 1 1) (make-inex 1 1 1))
(check-expect (convert 100 1 1) (make-inex 10 1 2))
(check-error (convert 0.1 0.1 0) ERR-RANGE)
(check-error (convert 0.1 -2 0) ERR-RANGE)
(check-error (convert 0.1 -1 -1) ERR-RANGE)
(check-error (convert 0.1 -1 100) ERR-RANGE)
(check-expect (convert 0.1 -1 0) (make-inex 1 -1 1))
(check-expect (convert 0.01 -1 0) (make-inex 1 -1 2))
(check-expect (convert 0.001 -1 0) (make-inex 1 -1 3))
(check-expect (convert 0.002 -1 0) (make-inex 2 -1 3))
(define (convert m s e)
  (if (not (and (<= 0 e 99) (or (= s 1) (= s -1))))
      (error ERR-RANGE)
      (cond
        [(and (integer? m) (<= 1 m 99)) (make-inex m s e)]
        [else (convert (if (= 1 s)
                           (round (/ m 10))
                           (* m 10))
                       s
                       (add1 e))])))

