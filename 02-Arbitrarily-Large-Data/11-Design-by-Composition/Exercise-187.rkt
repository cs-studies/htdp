;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-187) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 187.
;; Design a program that sorts lists of game players by score.


(define-struct gp [name score])
;; A GamePlayer is a structure:
;;    (make-gp String Number)
;; (make-gp p s) represents player p who
;; scored a maximum of s points.

;; A List-of-players is one of:
;; - '()
;; - (cons GamePlayer List-of-players)


;; List-of-players -> List-of-players
;; Produces a sorted by score version of the given list of players.
(check-expect (sort> '()) '())
(check-expect (sort> (list (make-gp "A" 10)))
              (list (make-gp "A" 10)))
(check-expect (sort> (list (make-gp "A" 10) (make-gp "B" 5)))
              (list (make-gp "A" 10) (make-gp "B" 5)))
(check-expect (sort> (list (make-gp "B" 5) (make-gp "A" 10)))
              (list (make-gp "A" 10) (make-gp "B" 5)))
(check-expect (sort> (list (make-gp "B" 5) (make-gp "Z" 20) (make-gp "A" 10)))
              (list (make-gp "Z" 20) (make-gp "A" 10) (make-gp "B" 5)))
(define (sort> l)
  (cond
    [(empty? l) '()]
    [else (insert (first l) (sort> (rest l)))]))


;; GamePlayer List-of-players -> List-of-players
;; Inserts a player into the sorted by score list of players.
(check-expect (insert (make-gp "A" 10) '())
              (list (make-gp "A" 10)))
(check-expect (insert (make-gp "A" 10) (list (make-gp "B" 5)))
              (list (make-gp "A" 10) (make-gp "B" 5)))
(check-expect (insert (make-gp "A" 10) (list (make-gp "Z" 20)))
              (list (make-gp "Z" 20) (make-gp "A" 10)))
(check-expect (insert (make-gp "A" 10) (list (make-gp "Z" 20) (make-gp "B" 5)))
              (list (make-gp "Z" 20) (make-gp "A" 10) (make-gp "B" 5)))
(define (insert gp l)
  (cond
    [(empty? l) (cons gp '())]
    [else (if (>= (gp-score gp) (gp-score (first l)))
              (cons gp l)
              (cons (first l) (insert gp (rest l))))]))


;;; Application

;(sort> (list (make-gp "B" 5) (make-gp "Z" 20) (make-gp "A" 10)))

