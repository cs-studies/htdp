;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-360) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 360.
;; Formulate a data definition for the representation of DrRacket’s definitions area.
;; Design the function lookup-con-def.
;; Design the function lookup-fun-def.


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

