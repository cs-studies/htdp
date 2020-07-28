;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-358) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 358.
;; Provide a structure type and a data definition for function definitions.
;; Work on lookup-def.


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
; ==
(define fundef-f
  (make-fundef 'f 'x (make-add 3 'x)))

(define (g y) (f (* 2 y)))
; ==
(define fundef-g
  (make-fundef 'g 'y (make-fun 'f (make-mul 2 'y))))

(define (h v) (+ (f v) (g v)))
; ==
(define fundef-h
  (make-fundef 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))


(define fundef-list (list fundef-f fundef-g fundef-h))

(define NOT-FOUND "Fundef not found.")


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

