;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-348) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 348.
;; Develop a data representation for Boolean BSL expressions
;; constructed from #true, #false, and, or, and not.
;; Then design eval-bool-expression,
;; which consumes (representations of) Boolean BSL expressions
;; and computes their values.


(define-struct con [left right])
;; A Con is a structure:
;;    (make-con BSL-bool-expr BSL-bool-expr)
;; (make-con b1 b2) represents a BSL expression
;; for evaluating of the conjunction of b1 and b2.

(define-struct dis [left right])
;; A Dis is a structure:
;;    (make-dis BSL-bool-expr BSL-bool-expr)
;; (make-dis b1 b2) represents a BSL expression
;; for evaluating of the disjunction of b1 and b2.

(define-struct neg [val])
;; A Neg is a structure:
;;    (make-neg BSL-bool-expr)
;; (make-neg r) represents a BSL expression
;; for evaluating of the negation of r.

;; BSL-bool-expr is one of:
;; - Boolean
;; - Con
;; - Dis
;; - Neg

;; A BSL-value is a Boolean.


;; BSL-bool-expr -> BSL-value
;; Computes value of the given BSL-bool-expr.
(check-expect (eval-bool-expression #true) #true)
(check-expect (eval-bool-expression #false) #false)
(check-expect (eval-bool-expression (make-con #true #false)) #false)
(check-expect (eval-bool-expression (make-con #true (make-dis #false #true))) #true)
(check-expect (eval-bool-expression
               (make-dis (make-neg #true) (make-con #false (make-neg #false)))) #false)
(define (eval-bool-expression expr)
  (cond
    [(boolean? expr) expr]
    [(neg? expr)
     (not (eval-bool-expression (neg-val expr)))]
    [(con? expr)
     (and (eval-bool-expression (con-left expr))
          (eval-bool-expression (con-right expr)))]
    [(dis? expr)
     (or (eval-bool-expression (dis-left expr))
         (eval-bool-expression (dis-right expr)))]))

