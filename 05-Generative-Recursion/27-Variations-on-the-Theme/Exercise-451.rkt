;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-451) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 451.
;; Design find-linear.
;; The function consumes a monotonically increasing table
;; and finds the smallest index for a root of the table.
;; Design find-binary,
;; which also finds the smallest index for the root
;; of a monotonically increasing table
;; but uses generative recursion to do so.


(require 2htdp/image)


;;; Data Definitions

;; N in one of:
;; - 0
;; - (add1 N)

(define-struct table [length array])
;; A Table is a structure:
;;   (make-table N [N -> Number])


;;; Constants

(define ERR-T2 "table2 is not defined for i =!= 0")

(define ERR-EMPTY "Empty table")

(define ERR-LIMIT "Length limit is reached")

(define ERR-NOT-FOUND "Root index is not found")

(define table1 (make-table 3 (lambda (i) i)))

;; N -> Number
(define (a2 i)
  (if (= i 0)
      pi
      (error ERR-T2)))

(define table2 (make-table 1 a2))

;(bitmap "./images/i-4.png")

(define table3 (make-table 10 (lambda (i) (- i 4))))

(define table4 (make-table 2 (lambda (i) (- i 4))))


;;; Functions

;; Table N -> Number
;; Looks up the ith value in array of t.
(define (table-ref t i)
  ((table-array t) i))

;; Table -> N
;; Finds the smallest index of a root
;; of the given monotonically increasing table.
(check-expect (find-linear table1) 0)
(check-error (find-linear table2) ERR-LIMIT)
(check-expect (find-linear table3) 4)
(check-error (find-linear table4) ERR-LIMIT)
(define (find-linear t)
  (local ((define len (table-length t))
          (define (find-linear* n)
            (cond
              [(= n len) (error ERR-LIMIT)]
              [else
               (if (zero? (table-ref t n))
                   n
                   (find-linear* (add1 n)))])))
    (find-linear* 0)))

;; Table -> N
;; Finds the smallest index of a root
;; of the given monotonically increasing table.
(check-error (find-binary (make-table 0 (lambda (i) i))) ERR-EMPTY)
(check-expect (find-binary (make-table 1 (lambda (i) i))) 0)
(check-expect (find-binary (make-table 2 (lambda (i) (- i 1)))) 1)
(check-expect (find-binary table1) 0)
(check-error (find-binary table2) ERR-NOT-FOUND)
(check-expect (find-binary table3) 4)
(check-error (find-binary table4) ERR-NOT-FOUND)
(define (find-binary t)
  (local ((define len (table-length t))
          (define (find-binary* l r)
            (local ((define (value-at n)
                      (table-ref t n))
                    (define f@l (value-at l))
                    (define f@r (value-at r))
                    (define distance (- r l)))
              (cond
                [(<= distance 1) (cond
                                   [(= f@l 0) l]
                                   [(= f@r 0) r]
                                   [else (error ERR-NOT-FOUND)])]
                [else
                 (local ((define mid (ceiling (/ (+ l r) 2)))
                         (define f@m (value-at mid)))
                   (cond
                     [(= f@m 0) mid]
                     [(> f@m 0) (find-binary* l mid)]
                     [else (find-binary* mid r)]))]))))
    (if (= 0 len)
        (error ERR-EMPTY)
        (find-binary* 0 (sub1 len)))))

