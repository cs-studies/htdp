;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-320) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 320.
;; Reformulate the data definition for S-expr
;; so that the first clause is expanded into the three clauses of Atom
;; and the second clause uses the List-of abstraction.
;; Redesign the count function for this data definition.
;; Now integrate the definition of SL into the one for S-expr.
;; Simplify count again. Consider using lambda.


(require 2htdp/abstraction)


;; An SL is a [List-of S-expr]

;; An S-expr is one of:
;; – Number
;; - String
;; - Symbol
;; – SL

;; S-expr Symbol -> N
;; Counts all occurrences of sy in sexp.
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)
(check-expect (count '(((2) "hello") 3) 'hello) 0)
(define (count sexp sy)
  (local ((define (count-list l)
            (cond
              [(empty? l) 0]
              [else (+
                     (count (first l) sy)
                     (count-list (rest l)))])))
    (cond
      [(number? sexp) 0]
      [(string? sexp) 0]
      [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
      [else (count-list sexp)])))


;; An S-expr is one of:
;; – Number
;; - String
;; - Symbol
;; - [List-of S-expr]

;; S-expr Symbol -> N
;; Counts all occurrences of sy in sexp.
(check-expect (count* 'world 'hello) 0)
(check-expect (count* '(world hello) 'hello) 1)
(check-expect (count* '(((world) hello) hello) 'hello) 2)
(check-expect (count* '(((2) "hello") 3) 'hello) 0)
(define (count* sexp sy)
  (cond
    [(number? sexp) 0]
    [(string? sexp) 0]
    [(symbol? sexp) (if (symbol=? sexp sy) 1 0)]
    ;[else (foldr (lambda (x y) (+ (count* x sy) y)) 0 sexp)]))
    [else (for/sum ([item sexp]) (count* item sy))]))

