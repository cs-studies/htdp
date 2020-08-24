;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-401) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 401.
;; Design sexp=?,
;; a function that determines whether two S-expressions are equal.
;; For convenience, here is the data definition in condensed form:


; An S-expr (S-expression) is one of:
; – Atom
; – [List-of S-expr]
;
; An Atom is one of:
; – Number
; – String
; – Symbol


;; S-expr S-expr -> Boolean
;; Determines whether two S-expressions are equal.
(check-expect (sexp=? 1 "a") #false)
(check-expect (sexp=? 1 'a) #false)
(check-expect (sexp=? 1 '(1)) #false)
(check-expect (sexp=? 1 0) #false)
(check-expect (sexp=? 1 1) #true)
(check-expect (sexp=? "a" 'a) #false)
(check-expect (sexp=? "a" 1) #false)
(check-expect (sexp=? "a" '("a")) #false)
(check-expect (sexp=? "a" "b") #false)
(check-expect (sexp=? "a" "a") #true)
(check-expect (sexp=? '() '()) #true)
(check-expect (sexp=? '() '("a")) #false)
(check-expect (sexp=? '("a") '()) #false)
(check-expect (sexp=? '("a") '("a")) #true)
(check-expect (sexp=? '("a" a 10 (-1 "cat")) '("a" a 10 '())) #false)
(check-expect (sexp=? '("a" a 10 (-1 "cat")) '("a" a 10 (-1 "cat"))) #true)
(define (sexp=? s1 s2)
  (cond
    [(and (number? s1) (number? s2)) (= s1 s2)]
    [(and (string? s1) (string? s2)) (string=? s1 s2)]
    [(and (symbol? s1) (symbol? s2)) (symbol=? s1 s2)]
    [(and (list? s1) (list? s2))
     (cond
       [(and (empty? s1) (empty? s2)) #true]
       [(or (empty? s1) (empty? s2)) #false]
       [else (and (sexp=? (first s1) (first s2))
                  (sexp=? (rest s1) (rest s2)))])]
    [else #false]))

