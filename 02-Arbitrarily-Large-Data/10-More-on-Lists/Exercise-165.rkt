;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-165) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 165.
;; Design the function subst-robot,
;; which consumes a list of toy descriptions (one-word strings)
;; and replaces all occurrences of "robot" with "r2d2"; all other descriptions remain the same.
;; Generalize subst-robot to substitute.
;; The latter consumes two strings, called new and old, and a list of strings.
;; It produces a new list of strings by substituting all occurrences of old with new.


(require racket/string)


;; A Toy is a one-word String.

;; A List-of-toys is one of:
;; - '()
;; - (cons Toy List-of-toys)

;; A List-of-strings is one of:
;; - '()
;; - (cons String List-of-strings)


;; List-of-toys -> List-of-toys
;; Replaces occurrences of "robot" with "r2d2".
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "dog" (cons "robot" '()))) (cons "dog" (cons "r2d2" '())))
#|
;; Template
(define (subst-robot toys)
  (cond
    [(empty? toys) ...]
    [else (... (first toys) ... (subst-robot (rest toys)) ...)]))
|#
(define (subst-robot toys)
  (cond
    [(empty? toys) '()]
    [else (cons (string-replace (first toys) "robot" "r2d2") (subst-robot (rest toys)))]))


;; List-of-strings String String -> List-of-strings
;; Produces a list of strings by substituting all occurrences of old with new.
(check-expect (substitute '() "arm" "rest") '())
(check-expect (substitute (cons "dog mat" (cons "automaton" '())) "ma" "ca")
              (cons "dog cat" (cons "autocaton" '())))
(define (substitute l-s old new)
  (cond
    [(empty? l-s) '()]
    [else (cons (string-replace (first l-s) old new) (substitute (rest l-s) old new))]))


;;; Application

;(subst-robot (cons "dog" (cons "robot" '())))

;(substitute (cons "dog mat" (cons "automaton" '())) "ma" "ca")

