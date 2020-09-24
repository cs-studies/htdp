;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-503) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 503.
;; Implement accumulator-style rotate function.


;; N is one of:
;; - 0
;; - (add1 N)

;; A Row is a [List-of N].

;; A Matrix is a [List-of Row].
;; Constraint: all Rows are of the same length.


(define ERR "All rows start with 0")


;; Matrix -> Matrix
;; Finds a row that doesn't start with 0 and
;; uses it as the first one.
;; Generative: moves the first row to last place.
;; Returns error if all rows start with 0.
(check-expect (rotate.v2 '((0 4 5) (1 2 3))) '((1 2 3) (0 4 5)))
(check-error (rotate.v2 '((0 4 5) (0 2 3))) ERR)
(define (rotate.v2 M)
  (local ((define (rotate/err M max)
            (cond
              [(not (= (first (first M)) 0)) M]
              [(zero? max) (error ERR)]
              [else (rotate/err
                     (append (rest M) (list (first M)))
                     (sub1 max))])))
    (rotate/err M (length M))))


;; Matrix -> Matrix
;; Finds a row that doesn't start with 0 and
;; uses it as the first one.
(check-expect (rotate '((0 4 5) (1 2 3))) '((1 2 3) (0 4 5)))
(check-expect (rotate '((0 4 5) (1 2 3) (2 5 6))) '((1 2 3) (2 5 6) (0 4 5)))
(check-expect (rotate '((0 4 5) (0 2 3) (2 5 6))) '((2 5 6) (0 4 5) (0 2 3)))
(check-error (rotate '((0 4 5) (0 2 3))) ERR)
(define (rotate M0)
  (local (;; Matrix [List-of Row] -> Matrix
          ;; Rotates a matrix.
          ;; Accumulator seen is a list of Rows
          ;; that are on M0 but not on M.
          (define (rotate/a M seen)
            (cond
              [(empty? M) (error ERR)]
              [(not (= (first (first M)) 0)) (append M (reverse seen))]
              [else (rotate/a (rest M) (cons (first M) seen))])))
    (rotate/a M0 '())))


;; N -> Matrix
;; Generates a matrix for use in performance tests.
(define (matrix n)
  (local ((define last-row (sub1 n))
          (define (row r)
            (local ((define (items i)
                      (if (= r last-row) 1 0)))
              (build-list 3 items))))
    (build-list n row)))

;(time (rotate.v2 (matrix 1000)))
;; rows 1000  2000  3000  4000  5000
;; time   40    97    21   233   257

;(time (rotate (matrix 1000)))
;; rows 1000  2000  3000  4000  5000  10000
;; time    0     0     0     0     0     11

