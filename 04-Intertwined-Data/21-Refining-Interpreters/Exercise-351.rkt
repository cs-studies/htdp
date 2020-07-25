;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-351) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 351.
;; Design interpreter-expr.


;; An Atom is one of:
;; – Number
;; – String
;; – Symbol

;; An S-expr is one of:
;; – Atom
;; – SL

;; An SL is a [List-of S-expr].

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


(define WRONG "Invalid expression.")


;;; Functions

;; S-expr -> BSL-value
;; Produces the value of S-expr,
;; if parse recognizes the given S-expr as valid BSL-expr.
;; Otherwise returns error.
(check-expect (interpreter-expr 10) 10)
(check-error (interpreter-expr "a") WRONG)
(check-error (interpreter-expr 'x) WRONG)
(check-error (interpreter-expr '(+ 1)) WRONG)
(check-expect (interpreter-expr '(+ 2 3)) 5)
(check-expect (interpreter-expr '(* 2 5)) 10)
(check-error (interpreter-expr '(^ 1 2)) WRONG)
(check-error (interpreter-expr '(+ 1 2 3)) WRONG)
(check-expect (interpreter-expr '(+ (* 3 3) (* 4 4))) 25)
(define (interpreter-expr expr)
  (local ((define (eval-expression expr)
            (cond
              [(number? expr) expr]
              [(add? expr)
               (+ (eval-expression (add-left expr))
                  (eval-expression (add-right expr)))]
              [(mul? expr)
               (* (eval-expression (mul-left expr))
                  (eval-expression (mul-right expr)))])))
    (eval-expression (parse expr))))

;; S-expr -> BSL-expr
(check-expect (parse 10) 10)
(check-error (parse "a") WRONG)
(check-error (parse 'x) WRONG)
(check-error (parse '(+ 1)) WRONG)
(check-expect (parse '(+ 2 3)) (make-add 2 3))
(check-expect (parse '(* 2 5)) (make-mul 2 5))
(check-error (parse '(^ 1 2)) WRONG)
(check-error (parse '(+ 1 2 3)) WRONG)
(define (parse s)
  (local (
          ;; SL -> BSL-expr
          (define (parse-sl s)
            (local ((define L (length s)))
              (cond
                [(< L 3) (error WRONG)]
                [(and (= L 3) (symbol? (first s)))
                 (cond
                   [(symbol=? (first s) '+)
                    (make-add (parse (second s)) (parse (third s)))]
                   [(symbol=? (first s) '*)
                    (make-mul (parse (second s)) (parse (third s)))]
                   [else (error WRONG)])]
                [else (error WRONG)])))

          ;; Atom -> BSL-expr
          (define (parse-atom s)
            (cond
              [(number? s) s]
              [(string? s) (error WRONG)]
              [(symbol? s) (error WRONG)])))
    (cond
      [(atom? s) (parse-atom s)]
      [else (parse-sl s)])))


;; Any -> Boolean
(define (atom? s)
  (or (number? s) (string? s) (symbol? s)))

