;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-514) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 514.
;; Make up an ISL+ expression in which x occurs both free and bound.
;; Formulate it as an element of Lam.
;; Does undeclareds work properly on your expression?


;; A Lam is one of:
;; – Symbol
;; - LExpr
;; - LApp

;; A LExpr is a
;; – (list 'λ (list Symbol) Lam)

;; A LApp is a
;; – (list Lam Lam)

(define ex1 '(λ (x) x))
(define ex2 '(λ (x) y))
(define ex3 '(λ (y) (λ (x) y)))
(define ex4 '((λ (x) (x x)) (λ (x) (x x))))
(define ex5 '((λ (x) x) (λ (x) x)))
(define ex6 '(((λ (y) (λ (x) y)) (λ (z) z)) (λ (w) w)))


;; Lam -> Lam
;; Replaces all symbols s in le with '*undeclared
;; if they do not occur within the body of a λ
;; expression whose parameter is s.
(check-expect (undeclareds ex1) ex1)
(check-expect (undeclareds ex2) '(λ (x) *undeclared))
(check-expect (undeclareds ex3) ex3)
(check-expect (undeclareds ex4) ex4)
(check-expect (undeclareds ex5) ex5)
(check-expect (undeclareds ex6) ex6)
(define (undeclareds le0)
  (local (
          (define (is-var? expr) (symbol? expr))

          (define (is-λ? expr) (and (cons? expr) (= 3 (length expr))))

          (define (is-app? expr) (and (cons? expr) (= 2 (length expr))))

          (define (λ-param e) (first (second e)))

          (define (λ-body e) (third e))

          (define (app-fun expr) (first expr))

          (define (app-arg expr) (second expr))

          ;; Lam [List-of Symbol] -> Lam
          ;; Accumulator declareds is a list of all λ
          ;; parameters on the path from le0 to le.
          (define (undeclareds/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds) le '*undeclared)]
              [(is-λ? le)
               (local ((define param (λ-param le))
                       (define body (λ-body le))
                       (define newd (cons param declareds)))
                 (list 'λ (list param)
                       (undeclareds/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
                 (list (undeclareds/a fun declareds)
                       (undeclareds/a arg declareds)))])))

    (undeclareds/a le0 '())))


;(undeclareds '(x (λ (x) x)))
;; outputs (list '*undeclared (list 'λ (list 'x) 'x))

;(undeclareds '((λ (x) x) (λ (y) x)))
;; outputs (list (list 'λ (list 'x) 'x) (list 'λ (list 'y) '*undeclared))

;; undeclareds works as expected.

