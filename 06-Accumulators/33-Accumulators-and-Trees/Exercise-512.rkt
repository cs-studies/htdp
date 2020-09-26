;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-512) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 512.
;; Define is-var?, is-λ?, and is-app?, that is,
;; predicates that distinguish variables from λ expressions and applications.
;; Also define
;; - λ-para, which extracts the parameter from a λ expression;
;; - λ-body, which extracts the body from a λ expression;
;; - app-fun, which extracts the function from an application; and
;; - app-arg, which extracts the argument from an application.
;; Design declareds,
;; which produces the list of all symbols used as λ parameters in a λ term.
;; Don’t worry about duplicate symbols.


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


;; Lam -> Boolean
;; Determines whether expr is a variable
;; (represented as Symbol).
(check-expect (is-var? 'b) #true)
(check-expect (is-var? '(λ (x) y)) #false)
(define (is-var? expr)
  (symbol? expr))

;; Lam -> Boolean
;; Determines whether expr is a λ-expression.
(check-expect (is-λ? 'b) #false)
(check-expect (is-λ? '(λ (x) y)) #true)
(check-expect (is-λ? '((λ (x) x) (λ (x) x))) #false)
(define (is-λ? expr)
  (and (cons? expr) (= 3 (length expr))))

;; Lam -> Boolean
;; Determines whether expr is a λ-application.
(check-expect (is-app? 'b) #false)
(check-expect (is-app? '(λ (x) y)) #false)
(check-expect (is-app? '((λ (x) x) (λ (x) x))) #true)
(define (is-app? expr)
  (and (cons? expr) (= 2 (length expr))))

;; LExpr -> Symbol
;; Extracts the parameter from e.
(check-expect (λ-param '(λ (x) y)) 'x)
(check-expect (λ-param '(λ (y) y)) 'y)
(define (λ-param e)
  (first (second e)))

;; LExpr -> Lam
;; Extracts the body from e.
(check-expect (λ-body '(λ (x) y)) 'y)
(check-expect (λ-body '(λ (y) (λ (x) y))) '(λ (x) y))
(define (λ-body e)
  (third e))

;; LApp -> Lam
;; Extracts the function from the application.
(check-expect (app-fun '((λ (x) x) (λ (x) x))) '(λ (x) x))
(define (app-fun expr)
  (first expr))

;; LApp -> Lam
;; Extracts the argument from the application.
(check-expect (app-arg '((λ (x) x) (λ (x) x))) '(λ (x) x))
(define (app-arg expr)
  (second expr))

;; Lam -> [List-of Symbol]
;; Produces a list of all symbols
;; used as λ parameters in a λ term.
(check-expect (declareds 'y) '())
(check-expect (declareds '(λ (x) y)) '(x))
(check-expect (declareds '((λ (x) x) (λ (x) x))) '(x x))
(check-satisfied (declareds ex6) (valid-declareds? '(y x z w)))
(define (declareds expr)
  (cond
    [(is-var? expr) '()]
    [(is-λ? expr) (cons (λ-param expr) (declareds (λ-body expr)))]
    [else (append (declareds (app-fun expr))
                  (declareds (app-arg expr)))]))

;; Lam -> [List-of Symbol]
;; Produces a list of all symbols
;; used as λ parameters in a λ term.
(check-expect (declareds.v2 'y) '())
(check-expect (declareds.v2 '(λ (x) y)) '(x))
(check-expect (declareds.v2 '((λ (x) x) (λ (x) x))) '(x x))
(check-satisfied (declareds.v2 ex6) (valid-declareds? '(y x z w)))
(define (declareds.v2 expr0)
  (local ((define (declareds/acc expr lod)
            (cond
              [(is-var? expr) lod]
              [(is-λ? expr)
               (declareds/acc (λ-body expr) (cons (λ-param expr) lod))]
              [else
               (declareds/acc (app-fun expr)
                              (declareds/acc (app-arg expr) lod))])))
    (declareds/acc expr0 '())))

;; [List-of Symbol] -> [[List-of Symbol] -> Boolean]
;; Produces a predicate to test declareds function.
(define (valid-declareds? l)
  (lambda (los)
    (if (= (length l) (length los))
        (and
         (andmap (lambda (s) (member? s l)) los)
         (andmap (lambda (s) (member? s los)) l))
        #false)))

;; N -> Lam
;; Generates a lambda representation for performance tests.
(define LITEM '(λ (x) x))
(check-expect (generate-lam 0) LITEM)
(check-expect (generate-lam 1) `(,LITEM ,LITEM))
(check-expect (generate-lam 2) `((,LITEM ,LITEM) (,LITEM ,LITEM)))
(check-expect (generate-lam 3) `(((,LITEM ,LITEM) (,LITEM ,LITEM))
                                 ((,LITEM ,LITEM) (,LITEM ,LITEM))))
(define (generate-lam size0)
  (local ((define (generate-lam/acc size a)
            (cond
              [(zero? size) a]
              [else (generate-lam/acc (sub1 size) (list a a))])))
    (generate-lam/acc size0 LITEM)))

;(time (declareds (generate-lam 10)))
;; size     10  12  15  17   20
;; time      0   0   0  11  494
;; time.v2   0   0   0   0  127

