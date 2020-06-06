;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-192) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 192.
;; Argue why it is acceptable to use last on Polygons.
;; Also argue why you may adapt the template for connect-dots to last.
;; Finally, develop examples for last, turn them into tests,
;; and ensure that the definition of last in figure 73 works on your examples.


(require 2htdp/image)


;;; Data Definitions

;; An NELoP is one of:
;; – (cons Posn '())
;; – (cons Posn NELoP)

;; A Polygon is one of:
;; – (list Posn Posn Posn)
;; – (cons Posn Polygon)


;;; Constants

(define SCENE (empty-scene 50 50))

(define triangle-p
  (list
   (make-posn 20 10)
   (make-posn 20 20)
   (make-posn 30 20)))

(define square-p
  (list
   (make-posn 10 10)
   (make-posn 20 10)
   (make-posn 20 20)
   (make-posn 10 20)))

;; Polygon -> Posn
;; Extracts the last item from p.
(check-expect (last triangle-p) (make-posn 30 20))
(check-expect (last square-p) (make-posn 10 20))
(define (last p)
  (cond
    [(empty? (rest (rest (rest p)))) (third p)]
    [else (last (rest p))]))


;;; Answer 1
;; It is acceptable to use last on Polygons
;; because Polygons are non-empty lists of Posns by the data definition.
;; Hence Polygons always contain a Posn as the last element.

;;; Answer 2
;; We may adapt the template for connect-dots to last
;; because connect-dots uses the template for functions
;; that process non-empty lists and last processes
;; non-empty lists too, since Polygon is a subset of NELoP
;; (non-empty lists of Posns).

