;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-400) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 400.
;; Design the function DNAprefix.
;; Also design DNAdelta.


;; A Nucleotide is one of:
;; - 'a
;; - 'c
;; - 'g
;; - 't

(define ERR-IDENTICAL "Identical lists.")


;; [List-of Nucleotide] [List-of Nucleotide] -> Boolean
;; Determines whether the pattern p is identical
;; to the initial part of the search string s.
(check-expect (DNAprefix '() '()) #true)
(check-expect (DNAprefix '() '(a)) #true)
(check-expect (DNAprefix '(a) '()) #false)
(check-expect (DNAprefix '(a) '(a)) #true)
(check-expect (DNAprefix '(a) '(c)) #false)
(check-expect (DNAprefix '(a) '(a c)) #true)
(check-expect (DNAprefix '(a c) '(a)) #false)
(check-expect (DNAprefix '(a c) '(a c)) #true)
(check-expect (DNAprefix '(a c) '(a c t)) #true)
(check-expect (DNAprefix '(g t) '(a g t)) #false)
#|
(define (DNAprefix p s)
  (cond
    [(and (empty? p) (empty? s)) ...]
    [(and (cons? p) (empty? s)) ...]
    [(and (empty? p) (cons? s)) ...]
    [(and (cons? p) (cons? s)) ...]))
|#
#|
(define (DNAprefix p s)
  (cond
    [(and (empty? p) (empty? s)) #true]
    [(and (cons? p) (empty? s)) #false]
    [(and (empty? p) (cons? s)) #true]
    [else (... (first p) ... (first s) ...
           ... (DNAprefix (rest p) (rest s)) ...)]))
|#
(define (DNAprefix p s)
  (cond
    [(empty? p) #true]
    [(and (cons? p) (empty? s)) #false]
    [else (and (symbol=? (first p) (first s))
               (DNAprefix (rest p) (rest s)))]))


;; [List-of Nucleotide] [List-of Nucleotide] -> Nucleotide
;; Produces the first item in the search string s beyond the pattern.
;; Signals an error if the lists are identical.
;; Returns #false if the pattern p does not match
;; the beginning of the search string s.
(check-error (DNAdelta '() '()) ERR-IDENTICAL)
(check-expect (DNAdelta '() '(a)) 'a)
(check-expect (DNAdelta '(a) '()) #false)
(check-error (DNAdelta '(a) '(a)) ERR-IDENTICAL)
(check-expect (DNAdelta '(a) '(c)) #false)
(check-expect (DNAdelta '(a) '(a c)) 'c)
(check-expect (DNAdelta '(a c) '(a)) #false)
(check-error (DNAdelta '(a c) '(a c)) ERR-IDENTICAL)
(check-expect (DNAdelta '(a c) '(a c t)) 't)
(check-expect (DNAdelta '(g t) '(a g t)) #false)
#|
(define (DNAdelta p s)
  (cond
    [(and (empty? p) (empty? s)) ...]
    [(and (cons? p) (empty? s)) ...]
    [(and (empty? p) (cons? s)) ...]
    [(and (cons? p) (cons? s)) ...]))
|#
#|
(define (DNAdelta p s)
  (cond
    [(and (empty? p) (empty? s)) (error ERR-IDENTICAL)]
    [(and (cons? p) (empty? s)) #false]
    [(and (empty? p) (cons? s)) (first s)]
    [else (... (first p) ... (first s) ...
           ... (DNAdelta (rest p) (rest s)) ...)]))
|#
(define (DNAdelta p s)
  (cond
    [(and (empty? p) (empty? s)) (error ERR-IDENTICAL)]
    [(and (cons? p) (empty? s)) #false]
    [(and (empty? p) (cons? s)) (first s)]
    [else (if (symbol=? (first p) (first s))
              (DNAdelta (rest p) (rest s))
              #false)]))

