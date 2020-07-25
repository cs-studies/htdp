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
;;    (make-con BSL-bool-repr BSL-bool-repr)
;; (make-con r1 r2) represents a BSL expression
;; for evaluating of the conjunction of r1 and r2.

(define-struct dis [left right])
;; A Dis is a structure:
;;    (make-dis BSL-bool-repr BSL-bool-repr)
;; (make-dis r1 r2) represents a BSL expression
;; for evaluating of the disjunction of r1 and r2.

(define-struct neg [val])
;; A Neg is a structure:
;;    (make-neg BSL-bool-repr)
;; (make-neg r) represents a BSL expression
;; for evaluating of the negation of r.

;; BSL-bool-repr is one of:
;; - Boolean
;; - Con
;; - Dis
;; - Neg

;; A BSL-value is a Boolean.


;; BSL-bool-repr -> BSL-value
;; Computes value of the given BSL-bool-repr.
(check-expect (eval-bool-expression #true) #true)
(check-expect (eval-bool-expression #false) #false)
(check-expect (eval-bool-expression (make-con #true #false)) #false)
(check-expect (eval-bool-expression (make-con #true (make-dis #false #true))) #true)
(check-expect (eval-bool-expression
               (make-dis (make-neg #true) (make-con #false (make-neg #false)))) #false)
(define (eval-bool-expression repr)
  (cond
    [(boolean? repr) repr]
    [(neg? repr)
     (not (eval-bool-expression (neg-val repr)))]
    [(con? repr)
     (and (eval-bool-expression (con-left repr))
          (eval-bool-expression (con-right repr)))]
    [(dis? repr)
     (or (eval-bool-expression (dis-left repr))
         (eval-bool-expression (dis-right repr)))]))

