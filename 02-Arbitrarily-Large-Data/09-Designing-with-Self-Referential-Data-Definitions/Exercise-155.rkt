;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-155) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 155.
;; Design the function inner,
;; which consumes an RD and produces the (color of the) innermost doll.


(define-struct layer [color doll])

;; A Doll is one of:
;; – String
;; – (make-layer String Doll)


;; Doll -> String
;; Produces the color of the innermost doll.
(check-expect (inner "red") "red")
(check-expect (inner (make-layer "yellow" (make-layer "red" "green"))) "green")
#|
;; Template
(define (inner d)
  (cond
    [(string? d) ...]
    [(layer? d) (... (layer-color d) ... (inner (layer-doll d) ...))]))
|#
(define (inner d)
  (cond
    [(string? d) d]
    [(layer? d) (inner (layer-doll d))]))

