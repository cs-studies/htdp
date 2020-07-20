;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-328) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 328.


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


;; S-expr Symbol Atom -> S-expr
;; Replaces all occurrences of old in sexp with new.
(check-expect (substitute '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))
(check-expect (substitute '(30 "a") 'cat 'fish) '(30 "a"))
(check-expect (substitute '(cat dog) 'cat 'fish) '(fish dog))
(check-expect (substitute '(((cat) dog) cat) 'cat 'fish) '(((fish) dog) fish))
(define (substitute sexp old new)
  (local ((define (atom? sexp)
            (or (number? sexp) (string? sexp) (symbol? sexp))))
    (cond
      [(atom? sexp) (if (equal? sexp old) new sexp)]
      [else (map (lambda (s) (substitute s old new)) sexp)])))

