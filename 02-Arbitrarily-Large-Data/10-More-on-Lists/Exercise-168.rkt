;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-168) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 168.
;; Design the function translate.
;; It consumes and produces lists of Posns.
;; For each (make-posn x y) in the former, the latter contains (make-posn x (+ y 1)).


;;; Data Definitions

;; A List-of-posns is one of:
;; - '()
;; - (cons Posn List-of-posns)


;;; Functions

;; List-of-posns -> List-of-posns
;; Translates each Posn on the list lp by 1.
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 10 30) (cons (make-posn 77 88) '())))
              (cons (make-posn 10 31) (cons (make-posn 77 89) '())))
#|
;; Template
(define (translate lp)
  (cond
    [(empty? lp) ...]
    [(cons? lp) (... (first lp) ...
                     ... ... (posn-x (first lp)) ...
                     ... ... (posn-y (first lp)) ...
                     (translate (rest lp)) ...)]))
|#
(define (translate lp)
  (cond
    [(empty? lp) '()]
    [(cons? lp)
     (cons (make-posn (posn-x (first lp)) (+ 1 (posn-y (first lp))))
           (translate (rest lp)))]))


;;; Application

;(translate (cons (make-posn 10 30) (cons (make-posn 77 88) '())))

