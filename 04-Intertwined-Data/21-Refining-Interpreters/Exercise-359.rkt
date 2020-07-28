;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-359) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 359.
;; Design eval-function*.


(define-struct add [left right])

(define-struct mul [left right])

(define-struct fun [name arg])

;; A BSL-fun-expr is one of:
;; – Number
;; - Symbol
;; – (make-add BSL-fun-expr BSL-fun-expr)
;; – (make-mul BSL-fun-expr BSL-fun-expr)
;; - (make-fun Symbol BSL-fun-expr)

(define-struct fundef [name param body])
;; A Fundef is a structure:
;;   (make-fundef Symbol Symbol BSL-fun-expr)
;; (make-fundef f p x) represents a function definition
;; with the function's name f,
;; the function's parameter p,
;; and the function's body x.

(define (f x) (+ 3 x))
(define fundef-f
  (make-fundef 'f 'x (make-add 3 'x)))

(define (g y) (f (* 2 y)))
(define fundef-g
  (make-fundef 'g 'y (make-fun 'f (make-mul 2 'y))))

(define (h v) (+ (f v) (g v)))
(define fundef-h
  (make-fundef 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

(define fundef-list (list fundef-f fundef-g fundef-h))

(define NOT-FOUND "Fundef not found.")
(define NOT-NUMERIC "Numeric BLS-fun-expr must be provided.")


;; BSL-fun-expr [List-of Fundef] -> Number
;; Determines the value of ex.
(check-expect (eval-function* (make-fun 'f (make-add 1 1)) fundef-list)
              (f (+ 1 1)))
(check-expect (eval-function* (make-fun 'g 3) fundef-list)
              (g 3))
(check-expect (eval-function*
               (make-mul 5 (make-fun 'f (make-add 1 2))) fundef-list)
              (* 5 (f (+ 1 2))))
(check-expect (eval-function*
               (make-mul 5 (make-fun 'g (make-add 1 2))) fundef-list)
              (* 5 (g (+ 1 2))))
(check-expect (eval-function*
               (make-mul 5 (make-fun 'h (make-add 2 (make-fun 'f (make-mul 2 1)))))
               fundef-list)
              (* 5 (h (+ 2 (f (* 2 1))))))
(check-error (eval-function* (make-fun 'k (make-add 1 1)) fundef-list)
             NOT-FOUND)
(check-error (eval-function* (make-fun 'f (make-add 'x 1)) fundef-list)
             NOT-NUMERIC)
(define (eval-function* ex l)
  (cond
    [(number? ex) ex]
    [(symbol? ex) (error NOT-NUMERIC)]
    [(add? ex) (+ (eval-function* (add-left ex) l)
                  (eval-function* (add-right ex) l))]
    [(mul? ex) (* (eval-function* (mul-left ex) l)
                  (eval-function* (mul-right ex) l))]
    [(fun? ex)
     (local ((define found-fundef (lookup-def l (fun-name ex)))
             (define param (fundef-param found-fundef))
             (define body (fundef-body found-fundef))
             (define value (eval-function* (fun-arg ex) l))
             (define plugd (subst body param value)))
       (eval-function* plugd l))]))

;; BSL-fun-expr Symbol Number -> BSL-fun-expr
;; Produces a BSL-fun-expr like ex
;; with the occurrences of x replaced by v
;; excluding the Fun structures.
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


;; [List-of Fundef] Symbol -> Fundef
;; Retrieves the definition of f in l.
;; Signals an error if there is none.
(check-expect (lookup-def fundef-list 'f) fundef-f)
(check-expect (lookup-def fundef-list 'h) fundef-h)
(check-error (lookup-def '() 'f) NOT-FOUND)
(define (lookup-def l f)
  (cond
    [(empty? l) (error NOT-FOUND)]
    [else (if (symbol=? f (fundef-name (first l)))
              (first l)
              (lookup-def (rest l) f))]))

