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
;;    (make-add BSL-repr BSL-repr)
;; (make-add repr1 repr2) represents
;; a BSL expression for addition of repr1 and repr2.

(define-struct mul [left right])
;; A Mul is a structure:
;;    (make-mul BSL-repr BSL-repr)
;; (make-mul repr1 repr2) represents
;; a BSL expression for multiplication of repr1 and repr2.

;; A BSL-repr is one of:
;; - Number
;; - Add
;; - Mul

;; A BSL-value is a Number.


;; BSL-repr -> BSL-value
;; Computes value of the given BSL-repr.
(check-expect (eval-expression 10) 10)
(check-expect (eval-expression (make-add 10 -10)) 0)
(check-expect (eval-expression (make-add (make-mul 20 3) 33)) 93)
(check-expect (eval-expression
               (make-mul (make-add 20 (make-add 10 10)) (make-mul 3 2))) 240)
(define (eval-expression repr)
  (cond
    [(number? repr) repr]
    [(add? repr)
     (+ (eval-expression (add-left repr))
        (eval-expression (add-right repr)))]
    [(mul? repr)
     (* (eval-expression (mul-left repr))
        (eval-expression (mul-right repr)))]))

