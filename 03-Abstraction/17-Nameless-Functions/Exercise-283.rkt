;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-283) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 283.
;; Confirm that DrRacket’s stepper can deal with lambda.


(map (lambda (x) (* 10 x))
     '(1 2 3))
; ==
; '(10 20 30)


(foldl (lambda (name rst)
         (string-append name ", " rst))
       "etc."
       '("Matthew" "Robby"))
; ==
; "Robby, Matthew, etc."


(define th 10)
(define-struct ir [name price])
(filter (lambda (ir) (<= (ir-price ir) th))
        (list (make-ir "bear" 10)
              (make-ir "doll" 33)))
; ==
; (list (make-ir "bear" 10))

