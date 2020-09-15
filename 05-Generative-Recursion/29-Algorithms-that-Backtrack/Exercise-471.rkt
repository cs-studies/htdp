;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-471) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 471.
;; Translate one of the above definitions
;; into proper list form using list and proper symbols.
;; Design the function neighbors.
;; It consumes a Node n and a Graph g
;; and produces the list of immediate neighbors of n in g.


(require 2htdp/image)

(place-image (bitmap "./images/graph-168.png") 300 100 (empty-scene 600 200 "white"))


;; A Node is a Symbol.

;; A Graph is a [List-of [List-of Node]].


(define sample-graph
  '((A B E)
    (B E F)
    (C D)
    (D)
    (E C F)
    (F D G)
    (G)))

(check-expect sample-graph (list (list 'A 'B 'E)
                                 (list 'B 'E 'F)
                                 (list 'C 'D)
                                 (list 'D)
                                 (list 'E 'C 'F)
                                 (list 'F 'D 'G)
                                 (list 'G)))


;; Node Graph -> [List-of Node]
;; Produces the list of immediate neighbors of n in g.
(check-expect (neighbors 'A '()) '())
(check-expect (neighbors 'A '((B))) '())
(check-expect (neighbors 'A '((B C E))) '())
(check-expect (neighbors 'A '((A))) '())
(check-expect (neighbors 'A '((A B))) '(B))
(check-expect (neighbors 'A '((A B C))) '(B C))
#|
(define (neighbors n g)
  (cond
    [(empty? g) '()]
    [else (if (symbol=? (first (first g)) n)
              (rest (first g))
              (neighbors n (rest g)))]))
|#
(define (neighbors n g)
  (local ((define found (assoc n g)))
    (if (false? found) '() (rest found))))

