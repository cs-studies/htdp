;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-234) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 234.
;; Create the function make-ranking,
;; which consumes a list of ranked song titles
;; and produces a list representation of an HTML table.


;; A Song is a list:
;;  (list Number String)


(define one-list
  '("Asia: Heat of the Moment"
    "U2: One"
    "The White Stripes: Seven Nation Army"))


;; List-of-strings -> ... nested list ...
;; Produces a list representations of an HTML table
;; representing ranked songs.
(define (make-ranking los)
  `(html
    (head
     (title "Ranked Songs")
     (body
      (table ((border "1"))
             ,@(make-rows (ranking los)))))))

;; List-of-songs -> ... nested list ...
;; Creates an HTML table rows from the list of songs.
(define (make-rows l)
  (cond
    [(empty? l) '()]
    [else (cons `(tr ,@(make-row (first l)))
                (make-rows (rest l)))]))

;; Song -> ... nested list ...
;; Creates a row for an HTML table from the given Song.
(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l))
                (make-row (rest l)))]))

;; NumberOrString -> ... nested list ...
;; Creates a cell for an HTML table from a number or a string.
(define (make-cell ns)
  (if (string? ns)
      `(td ,ns)
      `(td ,(number->string ns))))


;; List-of-strings -> ... nested list ...
;; Produces a list similar to the given,
;; but with ranks added.
(define (ranking los)
  (reverse (add-ranks (reverse los))))

;; List-of-strings -> ... nested list ...
;; Produces a list of lists with songs ranks and titles.
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))


;;; Applications

;(make-ranking one-list)

