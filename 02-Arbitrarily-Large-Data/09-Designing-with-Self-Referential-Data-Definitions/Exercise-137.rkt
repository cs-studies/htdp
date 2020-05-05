;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-137) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 137.
;; Compare the template for contains-flatt? with the one for how-many.
;; Ignoring the function name, they are the same. Explain the similarity.


;; List-of-names -> Boolean
;; Determines whether "Flatt" is on a-list-of-names.
(define (contains-flatt? alon)
  (cond
    [(empty? alon) ...]
    [else
     (... (first alon) ...
      ... (contains-flatt? (rest alon)) ...)]))


;; List-of-strings -> Number
;; Determines how many strings are on alos.
(define (how-many alos)
  (cond
    [(empty? alos) ...]
    [else
     (... (first alos) ...
      ... (how-many (rest alos)) ...)]))


;;; Answer
;; Templates are built based on a data definition.
;; Both of these templates deal with the self-referential List data definition.
;; Hence structures of the templates are similar.

