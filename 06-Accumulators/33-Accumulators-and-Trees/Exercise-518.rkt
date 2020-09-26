;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-518) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 518.
;; Argue that our-cons takes a constant amount of time
;; to compute its result, regardless of the size of its input.


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


;;; Answer
;; our-cons performs these actions:
;; - checks if cpair-right is an empty list
;; - or checks if cpair-right is an instance of cpair
;;   - and then makes one sum operation.
;; All of these actions are not dependent on any changing factors,
;; including the size of the input.
;; Hence our-cons takes a constant amount of time
;; to compute its result.

