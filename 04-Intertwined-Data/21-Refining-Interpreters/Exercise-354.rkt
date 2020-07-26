;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-354) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 354.
;; Design eval-variable.
;; The checked function consumes a BSL-var-expr
;; and determines its value if numeric? yields true for the input.
;; Otherwise it signals an error.
;;
;; Design eval-variable*.
;; The function consumes a BSL-var-expr ex and an association list da.
;; Starting from ex, it iteratively applies subst to all associations in da.
;; If numeric? holds for the result, it determines its value;
;; otherwise it signals the same error as eval-variable.


(define-struct add [left right])

(define-struct mul [left right])

;; A BSL-var-expr is one of:
;; – Number
;; – Symbol
;; – (make-add BSL-var-expr BSL-var-expr)
;; – (make-mul BSL-var-expr BSL-var-expr)

;; A BSL-expr is one of:
;; – Number
;; – (make-add BSL-expr BSL-expr)
;; – (make-mul BSL-expr BSL-expr)

;; A BSL-value is a Number.

(define NOT-NUMERIC "Numeric BLS-var-expr must be provided.")


;; BSL-var-expr -> BSL-value
(check-expect (eval-variable 100) 100)
(check-error (eval-variable 'x) NOT-NUMERIC)
(check-expect (eval-variable (make-add 5 3)) 8)
(check-error (eval-variable (make-add 'x 3)) NOT-NUMERIC)
(check-expect (eval-variable (make-mul 1/2 (make-mul 5 4))) 10)
(check-error (eval-variable (make-mul 1/2 (make-mul 'x 3))) NOT-NUMERIC)
(check-expect (eval-variable (make-add (make-mul 1 2) (make-add 10 2))) 14)
(check-error (eval-variable (make-add (make-mul 'x 'x) (make-add 'y 'y))) NOT-NUMERIC)
(define (eval-variable ex)
  (if (numeric? ex)
      (eval-expression ex)
      (error NOT-NUMERIC)))

;; BSL-var-expr -> Boolean
;; Determines whether BSL-var-expr is also a BSL-expr.
(check-expect (numeric? 100) #true)
(check-expect (numeric? 'x) #false)
(check-expect (numeric? (make-add 5 3)) #true)
(check-expect (numeric? (make-add 'x 3)) #false)
(check-expect (numeric? (make-mul 1/2 (make-mul 5 3))) #true)
(check-expect (numeric? (make-mul 1/2 (make-mul 'x 3))) #false)
(check-expect (numeric? (make-add (make-mul 1 2) (make-add 10 2))) #true)
(check-expect (numeric? (make-add (make-mul 'x 'x) (make-add 'y 'y))) #false)
(define (numeric? ex)
  (cond
    [(number? ex) #true]
    [(symbol? ex) #false]
    [(add? ex)
     (and (numeric? (add-left ex))
          (numeric? (add-right ex)))]
    [(mul? ex)
     (and (numeric? (mul-left ex))
          (numeric? (mul-right ex)))]))

;; BSL-expr -> BSL-value
;; Computes value of the given BSL-expr.
(check-expect (eval-expression 10) 10)
(check-expect (eval-expression (make-add 10 -10)) 0)
(check-expect (eval-expression (make-add (make-mul 20 3) 33)) 93)
(check-expect (eval-expression
               (make-mul (make-add 20 (make-add 10 10)) (make-mul 3 2))) 240)
(define (eval-expression ex)
  (cond
    [(number? ex) ex]
    [(add? ex)
     (+ (eval-expression (add-left ex))
        (eval-expression (add-right ex)))]
    [(mul? ex)
     (* (eval-expression (mul-left ex))
        (eval-expression (mul-right ex)))]))



;; An AL (short for association list) is [List-of Association].
;; An Association is a list of two items:
;;   (cons Symbol (cons Number '())).

(define a-1 (cons 'x (cons 3 '())))
(define a-2 (cons 'y (cons 5 '())))
(define al (list a-1 a-2))


;; BSL-var-expr AL -> BSL-value
;; Determines value of ex.
;; If ex is not numeric, produces NOT-NUMERIC error.
(check-expect (eval-variable* 100 '()) 100)
(check-expect (eval-variable* 100 al) 100)
(check-error (eval-variable* 'x '()) NOT-NUMERIC)
(check-expect (eval-variable* 'x al) 3)
(check-error (eval-variable* 'z al) NOT-NUMERIC)
(check-expect (eval-variable* (make-add 5 3) '()) 8)
(check-expect (eval-variable* (make-add 5 3) al) 8)
(check-expect (eval-variable* (make-add 'x 3) al) 6)
(check-error (eval-variable* (make-add 'z 3) al) NOT-NUMERIC)
(check-expect (eval-variable* (make-mul 1/2 (make-mul 'y 4)) al) 10)
(check-error (eval-variable* (make-mul 1/2 (make-mul 'z 3)) al) NOT-NUMERIC)
(check-expect (eval-variable* (make-add (make-mul 'x 'x) (make-add 'y 'y)) al) 19)  
(check-error (eval-variable* (make-add (make-mul 'x 'x) (make-add 'z 'z)) al)
             NOT-NUMERIC)
(define (eval-variable* ex l)
  (cond
    [(empty? l) (if (numeric? ex)
                     (eval-expression ex)
                     (error NOT-NUMERIC))]
    [else (eval-variable*
           (subst ex (first (first l)) (second (first l)))
           (rest l))]))

;; BSL-var-expr Symbol Number -> BSL-var-expr
;; Produces a BSL-var-expr like ex
;; with all occurrences of x replaced by v.
(check-expect (subst 100 'x 3) 100)
(check-expect (subst 'x 'x 10) 10)
(check-expect (subst 'x 'y 10) 'x)
(check-expect (subst (make-add 'x 3) 'x 20) (make-add 20 3))
(check-expect (subst (make-mul 1/2 (make-mul 'x 3)) 'x 10)
              (make-mul 1/2 (make-mul 10 3)))
(check-expect (subst (make-add (make-mul 'x 'x) (make-mul 'y 'y)) 'y 5)
              (make-add (make-mul 'x 'x) (make-mul 5 5)))
(define (subst ex x v)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (if (symbol=? ex x) v ex)]
    [(add? ex)
     (make-add (subst (add-left ex) x v)
               (subst (add-right ex) x v))]
    [(mul? ex)
     (make-mul (subst (mul-left ex) x v)
               (subst (mul-right ex) x v))]))

