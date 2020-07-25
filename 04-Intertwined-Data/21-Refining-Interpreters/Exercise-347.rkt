;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-347) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 347.
;; Design eval-expression.
;; The function consumes a representation of a BSL expression
;; and computes its value.


(define-struct add [left right])
;; An Add is a structure:
;;    (make-add BSL-expr BSL-expr)
;; (make-add expr1 expr2) represents
;; a BSL expression for addition of expr1 and expr2.

(define-struct mul [left right])
;; A Mul is a structure:
;;    (make-mul BSL-expr BSL-expr)
;; (make-mul expr1 expr2) represents
;; a BSL expression for multiplication of expr1 and expr2.

;; A BSL-expr is one of:
;; - Number
;; - Add
;; - Mul

;; A BSL-value is a Number.


;; BSL-expr -> BSL-value
;; Computes value of the given BSL-expr.
(check-expect (eval-expression 10) 10)
(check-expect (eval-expression (make-add 10 -10)) 0)
(check-expect (eval-expression (make-add (make-mul 20 3) 33)) 93)
(check-expect (eval-expression
               (make-mul (make-add 20 (make-add 10 10)) (make-mul 3 2))) 240)
(define (eval-expression expr)
  (cond
    [(number? expr) expr]
    [(add? expr)
     (+ (eval-expression (add-left expr))
        (eval-expression (add-right expr)))]
    [(mul? expr)
     (* (eval-expression (mul-left expr))
        (eval-expression (mul-right expr)))]))

