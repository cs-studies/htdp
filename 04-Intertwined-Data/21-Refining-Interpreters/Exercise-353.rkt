;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-353) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 353.
;; Design the numeric? function.
;; It determines whether a BSL-var-expr is also a BSL-expr.


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

