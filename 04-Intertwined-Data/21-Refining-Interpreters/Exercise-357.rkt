;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-357) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 357.
;; Design eval-definition1.


(define-struct add [left right])

(define-struct mul [left right])

(define-struct fun [name arg])

;; A BSL-fun-expr is one of:
;; – Number
;; - Symbol
;; – (make-add BSL-fun-expr BSL-fun-expr)
;; – (make-mul BSL-fun-expr BSL-fun-expr)
;; - (make-fun Symbol BSL-fun-expr)

(define NOT-NUMERIC "Numeric BLS-fun-expr must be provided.")
(define WRONG-FUNC-NAME "Function name must be f.")


(define fun-k
  (make-fun 'k (make-add 1 1)))

(define mul-5
  (make-mul 5 fun-k))

;; BSL-fun-expr Symbol Symbol BSL-fun-expr -> Number
;; Determines the value of ex.
(check-expect (eval-definition1 10 'f 'x (make-add 'x 2)) 10)
(check-expect (eval-definition1 (make-add 1 2) 'f 'x  (make-add 'x 2)) 3)
(check-expect (eval-definition1 fun-k 'k 'x (make-add 'x 2))
              (+ (+ 1 1) 2))
(check-expect (eval-definition1 mul-5 'k 'x (make-add 'x 2))
              (* 5 (+ (+ 1 1) 2)))
(check-expect (eval-definition1
               (make-mul 5 (make-fun 'g (make-add 1 (make-fun 'g (make-mul 2 3)))))
               'g 'x
               (make-add 'x 2))
              (* 5 (+ (+ 1 (+ (* 2 3) 2)) 2)))
(check-error (eval-definition1 fun-k 'f 'x (make-mul 'x 10)) WRONG-FUNC-NAME)
(check-error (eval-definition1
              (make-fun 'k (make-add 'x 1))
              'k 'z
              (make-mul 'z 10))
             NOT-NUMERIC)
(define (eval-definition1 ex f x b)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error NOT-NUMERIC)]
    [(add? ex) (+ (eval-definition1 (add-left ex) f x b)
                  (eval-definition1 (add-right ex) f x b))]
    [(mul? ex) (* (eval-definition1 (mul-left ex) f x b)
                  (eval-definition1 (mul-right ex) f x b))]
    [(fun? ex)
     (if (not (symbol=? (fun-name ex) f))
         (error WRONG-FUNC-NAME)
         (local ((define value (eval-definition1 (fun-arg ex) f x b))
                 (define plugd (subst b x value)))
           (eval-definition1 plugd f x b)))]))


;; BSL-fun-expr Symbol Number -> BSL-fun-expr
;; Produces a BSL-fun-expr like ex
;; with the occurrences of x replaced by v.
(check-expect (subst 100 'x 3) 100)
(check-expect (subst 'x 'x 10) 10)
(check-expect (subst 'x 'y 10) 'x)
(check-expect (subst (make-add 'x 3) 'x 20) (make-add 20 3))
(check-expect (subst (make-mul 1/2 (make-mul 'x 3)) 'x 10)
              (make-mul 1/2 (make-mul 10 3)))
(check-expect (subst (make-add (make-mul 'x 'x) (make-mul 'y 'y)) 'y 5)
              (make-add (make-mul 'x 'x) (make-mul 5 5)))
(check-expect (subst (make-fun 'f (make-add 2 'y)) 'y 3)
              (make-fun 'f (make-add 2 3)))
(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (symbol=? ex x) v ex)]
    [(add? ex)
     (make-add (subst (add-left ex) x v)
               (subst (add-right ex) x v))]
    [(mul? ex)
     (make-mul (subst (mul-left ex) x v)
               (subst (mul-right ex) x v))]
    [(fun? ex) (make-fun
                (fun-name ex)
                (subst (fun-arg ex) x v))]))

