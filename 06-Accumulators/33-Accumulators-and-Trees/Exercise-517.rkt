;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-517) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 517.
;; Design static-distance.
;; The function replaces all occurrences of variables with a natural number
;; that represents how far away the declaring λ is.


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
(define ex4 '((λ (x) ((λ (y) (y x)) x)) (λ (z) z)))

;; Lam -> Lam
;; Replaces all symbols s in le with a natural
;; number that represents how far away the declaring λ is.
(check-expect (static-distance ex1) '(λ (x) 0))
(check-expect (static-distance ex2) '(λ (x) y))
(check-expect (static-distance ex3) '(λ (y) (λ (x) 1)))
(check-expect (static-distance ex4) '((λ (x) ((λ (y) (0 1)) 0)) (λ (z) 0)))
(define (static-distance le0)
  (local (
          (define (is-var? expr) (symbol? expr))

          (define (is-λ? expr) (and (cons? expr) (= 3 (length expr))))

          (define (is-app? expr) (and (cons? expr) (= 2 (length expr))))

          (define (λ-param e) (first (second e)))

          (define (λ-body e) (third e))

          (define (app-fun expr) (first expr))

          (define (app-arg expr) (second expr))

          ;; [List-of Symbol] Symbol -> [Maybe N]
          (define (index-of l0 i)
            (local (;; [List-of Symbol] N -> [Maybe N]
                    ;; Accumulator n is an index on l0
                    ;; of the first item of l.
                    (define (index-of/a l n)
                      (cond
                        [(empty? l) (error "Not found")]
                        [(symbol=? (first l) i) n]
                        [else (index-of/a (rest l) (add1 n))])))
              (index-of/a l0 0)))

          ;; Lam [List-of Symbol] -> Lam
          ;; Accumulator declareds is a list of all λ
          ;; parameters on the path from le0 to le.
          (define (static-distance/a le declareds)
            (cond
              [(is-var? le)
               (if (member? le declareds)
                   (index-of declareds le)
                   le)]
              [(is-λ? le)
               (local ((define param (λ-param le))
                       (define body (λ-body le))
                       (define newd (cons param declareds)))
                 (list 'λ (list param)
                       (static-distance/a body newd)))]
              [(is-app? le)
               (local ((define fun (app-fun le))
                       (define arg (app-arg le)))
                 (list (static-distance/a fun declareds)
                       (static-distance/a arg declareds)))])))

    (static-distance/a le0 '())))

