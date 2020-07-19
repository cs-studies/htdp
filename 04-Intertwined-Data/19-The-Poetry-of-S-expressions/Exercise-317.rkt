;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-317) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 317.
;; Copy and reorganize the program from figure 117
;; into a single function using local.


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

;; S-expr Symbol -> N
;; Counts all occurrences of sy in sexp.
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)
(check-expect (count '(((2) "hello") 3) 'hello) 0)
(define (count sexp sy)
  (local (
          (define (atom? sexp)
            (or
             (number? sexp)
             (string? sexp)
             (symbol? sexp)))

          (define (count-atom at)
            (cond
              [(number? at) 0]
              [(string? at) 0]
              [(symbol? at) (if (symbol=? at sy) 1 0)]))

          (define (count-sl sl)
            (cond
              [(empty? sl) 0]
              [else (+
                     (count (first sl) sy)
                     (count-sl (rest sl)))])))

    (cond
      [(atom? sexp) (count-atom sexp)]
      [else (count-sl sexp)])))

