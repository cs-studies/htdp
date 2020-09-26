;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-519) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 519.
;; Is it acceptable to impose the extra cost on cons
;; for all programs to turn length into a constant-time function?


(define-struct cpair [count left right])
;; A [MyList X] is one of:
;; – '()
;; – (make-cpair (tech "N") X [MyList X])
;; Accumulator: the count field is the number of cpairs.

;; Data definitions, via a constructor-function.
(define (our-cons f r)
  (cond
    [(empty? r) (make-cpair 1 f r)]
    [(cpair? r) (make-cpair (+ (cpair-count r) 1) f r)]
    [else (error "our-cons: ...")]))

;; Any -> N
;; How many items does l contain.
(define (our-length l)
  (cond
    [(empty? l) 0]
    [(cpair? l) (cpair-count l)]
    [else (error "my-length: ...")]))


;;; Answer
;; It is acceptable when a program
;; makes many calls to our-length function
;; and performs a small number of writes/removals on cons.

