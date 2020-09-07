;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-454) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 454.
;; Design create-matrix.
;; The function consumes a number n and a list of n2 numbers.
;; It produces an n x n matrix.


;; N is one of:
;; - 0
;; - (add1 N)

(define ERR "Size of the list must be (* n n)")

;; N [List-of N] -> [List-of [List-of N]]
;; Produces an N x N matrix.
(check-expect (create-matrix 0 '()) '())
(check-expect (create-matrix 1 (list 1)) (list (list 1)))
(check-expect (create-matrix 2 (list 1 2 3 4))
              (list (list 1 2)
                    (list 3 4)))
(check-expect (create-matrix 3 (list 1 2 3 4 5 6 7 8 9))
              (list (list 1 2 3)
                    (list 4 5 6)
                    (list 7 8 9)))
(check-error (create-matrix 2 '(1)) ERR)
(check-error (create-matrix 2 '(1 2 3 4 5)) ERR)
(define (create-matrix n l)
  (local ((define (create-matrix* l)
            (cond
              [(empty? l) '()]
              [else (cons (first-items n l)
                          (create-matrix* (remove-first-items n l)))])))
    (if (not (= (length l) (* n n)))
        (error ERR)
        (create-matrix* l))))

;; N [List-of Any] -> [List-of Any]
;; Produces a list from the first N values on the given list.
(check-expect (first-items 0 '()) '())
(check-expect (first-items 1 '()) '())
(check-expect (first-items 0 '(10)) '())
(check-expect (first-items 1 '(10)) '(10))
(check-expect (first-items 1 '(10 20)) '(10))
(check-expect (first-items 2 '(10 20 30 40)) '(10 20))
(define (first-items n l)
  (cond
    [(or (zero? n) (empty? l)) '()]
    [else (cons (first l) (first-items (sub1 n) (rest l)))]))

;; N [List-of Any] -> [List-of Any]
;; Removes the first N items from the given list.
(check-expect (remove-first-items 0 '()) '())
(check-expect (remove-first-items 1 '()) '())
(check-expect (remove-first-items 0 '(10)) '(10))
(check-expect (remove-first-items 1 '(10)) '())
(check-expect (remove-first-items 1 '(10 20)) '(20))
(check-expect (remove-first-items 2 '(10 20 30 40)) '(30 40))
(define (remove-first-items n l)
  (cond
    [(or (zero? n) (empty? l)) l]
    [else (remove-first-items (sub1 n) (rest l))]))

