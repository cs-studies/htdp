;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-361) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 361.
;; Design eval-all.


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

(define-struct condef [name expr])
;; A Condef is a structure:
;;   (make-condef Symbol BSL-fun-expr)
;; (make-condef n v) represents a constant definition
;; with the name n and the expr v.

;; A BSL-da is one of:
;; - Fundef
;; - Condef

;; A BSL-da-all is a [List-of BSL-da]


(define NOT-FOUND "Definition not found.")


(define close-to-pi 3.14)

(define condef-1
  (make-condef
   'close-to-pi
   3.14))


(define (area-of-circle r)
  (* close-to-pi (* r r)))

(define fundef-1
  (make-fundef
   'area-of-circle
   'r
   (make-mul 'close-to-pi (make-mul 'r 'r))))


(define (volume-of-10-cylinder r)
  (* 10 (area-of-circle r)))

(define fundef-2
  (make-fundef
   'volume-of-10-cylinder
   'r
   (make-mul 10 (make-fun 'area-of-circle 'r))))


(define da-all (list condef-1 fundef-1 fundef-2))


;; BSL-fun-expr BSL-da-all -> Number
;; Produces the same value that DrRacket
;; would show in the interations area.
(check-expect (eval-all 3 da-all) 3)
(check-expect (eval-all 'close-to-pi da-all) 3.14)
(check-expect (eval-all (make-add 2 3) da-all) 5)
(check-expect (eval-all (make-mul 2 3) da-all) 6)
(check-expect (eval-all (make-fun 'area-of-circle (make-add 1 1)) da-all)
              (* 3.14 2 2))
(check-expect (eval-all
               (make-mul 5 (make-fun 'volume-of-10-cylinder (make-add 1 1))) da-all)
              (* 5 10 3.14 2 2)) ; 628
(check-error (eval-all (make-fun 'k (make-add 1 1)) da-all)
             NOT-FOUND)
(define (eval-all ex da)
  (cond
    [(number? ex) ex]
    [(symbol? ex)
     (local ((define found-condef (lookup-con-def da ex)))
       (eval-all (condef-expr found-condef) da))]
    [(add? ex) (+ (eval-all (add-left ex) da)
                  (eval-all (add-right ex) da))]
    [(mul? ex) (* (eval-all (mul-left ex) da)
                  (eval-all (mul-right ex) da))]
    [(fun? ex)
     (local ((define found-fundef (lookup-fun-def da (fun-name ex)))
             (define param (fundef-param found-fundef))
             (define body (fundef-body found-fundef))
             (define value (eval-all (fun-arg ex) da))
             (define plugd (subst body param value)))
       (eval-all plugd da))]))

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

;; BSL-da-all Symbol -> Condef
;; Produces the representation of a constant definition
;; whose name is x.
;; If x not found in da, signals an error.
(check-error (lookup-con-def '() 'm) NOT-FOUND)
(check-error (lookup-con-def da-all 'm) NOT-FOUND)
(check-error (lookup-con-def da-all 'volume-of-10-cylinder) NOT-FOUND)
(check-expect (lookup-con-def da-all 'close-to-pi) condef-1)
(define (lookup-con-def da x)
  (cond
    [(empty? da) (error NOT-FOUND)]
    [else (if (and (condef? (first da)) (symbol=? x (condef-name (first da))))
              (first da)
              (lookup-con-def (rest da) x))]))

;; BSL-da-all Symbol -> Fundef
;; Produces the representation of a function definition
;; whose name is f.
;; If x not found in da, signals an error.
(check-error (lookup-fun-def '() 'm) NOT-FOUND)
(check-error (lookup-fun-def da-all 'm) NOT-FOUND)
(check-error (lookup-fun-def da-all 'close-to-pi) NOT-FOUND)
(check-expect (lookup-fun-def da-all 'volume-of-10-cylinder) fundef-2)
(define (lookup-fun-def da f)
  (cond
    [(empty? da) (error NOT-FOUND)]
    [else (if (and (fundef? (first da)) (symbol=? f (fundef-name (first da))))
              (first da)
              (lookup-fun-def (rest da) f))]))

