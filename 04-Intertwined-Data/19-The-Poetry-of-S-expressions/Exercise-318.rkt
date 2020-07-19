;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-318) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 318.
;; Design depth.
;; The function consumes an S-expression and determines its depth.
;; An Atom has a depth of 1.
;; The depth of a list of S-expressions is the maximum depth of its items plus 1.


;; An Atom is one of:
;; – Number
;; – String
;; – Symbol

;; An SL is one of:
;; – '()
;; – (cons S-expr SL)

;; An S-expr is one of:
;; – Atom
;; – SL


;; S-expr -> Number
;; Determines the depth of the sexp.
(check-expect (depth 10) 1)
(check-expect (depth "a") 1)
(check-expect (depth 'x) 1)
(check-expect (depth '()) 1)
(check-expect (depth (cons 10 '())) 2)
(check-expect (depth (cons 10 (cons 5 '()))) 3)
(check-expect (depth (cons (cons 10 '()) '())) 3)
(define (depth sexp)
  (local (
          (define (atom? sexp)
            (or
             (number? sexp)
             (string? sexp)
             (symbol? sexp)))

          (define (depth-sl sl)
            (cond
              [(empty? sl) 1]
              [else (+ (depth (first sl))
                       (depth-sl (rest sl)))])))
    (cond
      [(atom? sexp) 1]
      [else (depth-sl sexp)])))

