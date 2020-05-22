;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-176) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 176.
;; Design the two wish-list functions.
;; Then complete the design of transpose with some test cases.


;;; Data Definitions

;; A Row is one of:
;;  – '()
;;  – (cons Number Row)

;; A Matrix is one of:
;;  – (cons Row '())
;;  – (cons Row Matrix)
;; Constraint: all rows in matrix are of the same length.


;;; Test Data

(define row1 (cons 11 (cons 21 '())))
(define row2 (cons 12 (cons 22 '())))
(define m1 (cons row1 (cons row2 '())))

(define col1 (cons 11 (cons 12 '())))
(define col2 (cons 21 (cons 22 '())))
(define m2 (cons col1 (cons col2 '())))

(define r1 (cons 11 (cons 21 (cons 31 '()))))
(define r2 (cons 12 (cons 22 (cons 32 '()))))
(define r3 (cons 13 (cons 23 (cons 33 '()))))
(define m3 (cons r1 (cons r2 (cons r3 '()))))


;;; Functions

;; Matrix -> Matrix
;; Transposes the given matrix:
;; rows become columns and vice-versa.
;; Returns an empty Row if the given Matrix does not contain data.
(check-expect (transpose (cons '() '())) '())
(check-expect (transpose m1) m2)
(check-expect (transpose m2) m1)
(define (transpose lln)
  (cond
    [(empty? (first lln)) '()]
    [else (cons (first* lln) (transpose (rest* lln)))]))

;; Matrix -> Row
;; Produces the first column of the given matrix.
;; The column matches Row data type.
(check-expect (first* m1) col1)
(check-expect (first* m2) row1)
(check-expect (first* m3) (cons 11 (cons 12 (cons 13 '()))))
#|
(define (first* m)
  (cond
    [(empty? m) ...]
    [else (... (first m) ... (first* (rest m)) ...)]))
|#
(define (first* m)
  (cond
    [(empty? m) '()]
    [else (cons (first (first m)) (first* (rest m)))]))

;; Matrix -> Matrix
;; Removes the first column from the given matrix.
(check-expect (rest* m1) (cons (cons 21 '()) (cons (cons 22 '()) '())))
(check-expect (rest* m2) (cons (cons 12 '()) (cons (cons 22 '()) '())))
#|
(define (rest* m)
  (cond
    [(empty? m) ...]
    [else (... (first m) ... (rest* (rest m)) ...)]))
|#
(define (rest* m)
  (cond
    [(empty? m) '()]
    [else (cons (rest (first m)) (rest* (rest m)))]))


;;; Question 1.
;; Why does transpose ask (empty? (first lln))?

;;; Answer 1.
;; Because, by the data definition, a Matrix cannot be an empty list.
;; (empty? (first lln)) checks if a Row is empty, which is possible by the definition.

;;; Question 2.
;; You cannot design this function with the design recipes you have seen so far. Why?

;;; Answer 2.
;; The function transpose acts on the elements of a Matrix not strictly sequentially,
;; as it was done by the previous design recipes, but in a specific order.
;; Namely, transpose works with the n-th elements of all the rows on each - recursive - call.
;; (In other words, transpose always works with the 1st elements of all the rows.)
;; Previously, each design recipe would work with the elements of the rows sequentially,
;; one by one.


;;; Application

;(transpose m3)

