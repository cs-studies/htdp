;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-515) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 515.
;; Represent the following expression in Lam.
;; Modify undeclareds so that it replaces a free occurrence of 'x with
;; (list '*undeclared 'x)
;; and a bound one 'y with
;; (list '*declared 'y)


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
(define ex4 '((λ (y) x) (λ (x) x)))


;(undeclareds '(λ (*undeclared) ((λ (x) (x *undeclared)) y)))
;; Produces
;; (list 'λ (list '*undeclared) (list (list 'λ (list 'x) (list 'x '*undeclared)) '*undeclared))


;; Lam -> Lam
;; Replaces all symbols s in le with '*undeclared
;; if they do not occur within the body of a λ
;; expression whose parameter is s.
(check-expect (undeclareds ex1) '(λ (x) *declared:x))
(check-expect (undeclareds ex2) '(λ (x) *undeclared:y))
(check-expect (undeclareds ex3) '(λ (y) (λ (x) *declared:y)))
(check-expect (undeclareds ex4) '((λ (y) *undeclared:x) (λ (x) *declared:x)))
(define (undeclareds le0)
  (local (
          (define (is-var? expr) (symbol? expr))

          (define (is-λ? expr) (and (cons? expr) (= 3 (length expr))))

          (define (is-app? expr) (and (cons? expr) (= 2 (length expr))))

          (define (λ-param e) (first (second e)))

          (define (λ-body e) (third e))

          (define (app-fun expr) (first expr))

          (define (app-arg expr) (second expr))

          ;; String Symbol -> String
          (define (build-name pref s)
            (string->symbol (string-append "*" pref "declared:" (symbol->string s))))

          ;; Lam [List-of Symbol] -> Lam
          ;; Accumulator declareds is a list of all λ
          ;; parameters on the path from le0 to le.
          (define (undeclareds/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds) (build-name "" le) (build-name "un" le))]
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
;; outputs (list '*undeclared:x (list 'λ (list 'x) '*declared:x))

;(undeclareds '((λ (x) x) (λ (y) x)))
;; outputs (list (list 'λ (list 'x) '*declared:x) (list 'λ (list 'y) '*undeclared:x))

