;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-319) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 319.
;; Design substitute.
;; It consumes an S-expression s and two symbols, old and new.
;; The result is like s with all occurrences of old replaced by new.


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


;; S-expr Symbol Symbol -> S-expr
;; Produces an S-expression like the given one
;; but with all occurrences of the old symbol replaced by the new symbol.
(check-expect (substitute '(30 "a") 'cat 'fish) '(30 "a"))
(check-expect (substitute '(cat dog) 'cat 'fish) '(fish dog))
(check-expect (substitute '(((cat) dog) cat) 'cat 'fish) '(((fish) dog) fish))
(define (substitute sexp old new)
  (local (
          (define (atom? sexp)
            (or
             (number? sexp)
             (string? sexp)
             (symbol? sexp)))

          (define (substitute-atom at)
            (cond
              [(or (number? at) (string? at)) at]
              [(symbol? at) (if (eq? at old) new at)]))

          (define (substitute-sl sl)
            (cond
              [(empty? sl) '()]
              [else (cons
                     (substitute (first sl) old new)
                     (substitute-sl (rest sl)))])))

    (cond
      [(atom? sexp) (substitute-atom sexp)]
      [else (substitute-sl sexp)])))

