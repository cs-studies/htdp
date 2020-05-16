;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-169) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 169.
;; Design the function legal.
;; It consumes and produces lists of Posns.
;; The result contains all those Posns
;; whose x-coordinates are between 0 and 100
;; and whose y-coordinates are between 0 and 200.


;;; Data Definitions

;; A List-of-posns is one of:
;; - '()
;; - (cons Posn List-of-posns)


;;; Functions

;; List-of-posns -> List-of-posns
;; Limits a list of Posns to the ones with
;; x-coordinates between 0 and 100
;; and y-coordinates between 0 and 200.
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 10 30) (cons (make-posn 177 88) (cons (make-posn 10 201) '()))))
              (cons (make-posn 10 30) '()))
#|
;; Template
(define (legal lp)
  (cond
    [(empty? lp) ...]
    [(cons? lp) (... (first lp) ...
                     ... ... (posn-x (first lp)) ...
                     ... ... (posn-y (first lp)) ...
                     (legal (rest lp)) ...)]))
|#
(define (legal lp)
  (cond
    [(empty? lp) '()]
    [(cons? lp)
     (if (and
          (>= (posn-x (first lp)) 0) (<= (posn-x (first lp)) 100)
          (>= (posn-y (first lp)) 0) (<= (posn-y (first lp)) 200))
         (cons (first lp) (legal (rest lp)))
         (legal (rest lp)))]))


;;; Application

;(legal (cons (make-posn 10 30) (cons (make-posn 177 88) '())))


