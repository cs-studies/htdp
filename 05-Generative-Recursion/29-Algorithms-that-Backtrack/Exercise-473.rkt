;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-473) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 473.
;; Test find-path on 'B, 'C, and the graph in figure 170.
;; Also use test-on-all-nodes from exercise 472 on this graph.


(require 2htdp/image)

(place-image (bitmap "./images/graph-170.png") 300 100 (empty-scene 600 200 "white"))


;; A Node is a Symbol.

;; A Graph is a [List-of [List-of Node]].

;; A Path is a [List-of Node].


(define sample-graph
  '((A B E)
    (B E F)
    (C D)
    (D)
    (E C F)
    (F D G)
    (G)))

(define cyclic-graph
  '((A B E)
    (B E F)
    (C B D)
    (D)
    (E C F)
    (F D G)
    (G)))


;; Node Node Graph -> [Maybe Path]
;; Finds a path from origination to destination in G.
;; If there is no path, the function produces #false.
(check-expect (find-path 'C 'D sample-graph) '(C D))
(check-member-of (find-path 'E 'D sample-graph) '(E F D) '(E C D))
(check-expect (find-path 'C 'G sample-graph) #false)
(check-expect (find-path 'A 'G sample-graph) '(A B E F G))
(check-expect (find-path 'B 'C cyclic-graph) '(B E C))
(define (find-path origination destination G)
  (cond
    [(symbol=? origination destination) (list destination)]
    [else (local ((define (neighbors n g)
                    (local ((define found (assoc n g)))
                      (if (false? found) #false (rest found))))
                  (define next (neighbors origination G))
                  (define candidate (find-path/list next destination G)))
            (cond
              [(boolean? candidate) #false]
              [else (cons origination candidate)]))]))


;; [List-of Node] Node Graph -> [Maybe Path]
;; Finds a path from some node on Os to D.
;; If there is no path, the function produces #false
(define (find-path/list Os D G)
  (cond
    [(empty? Os) #false]
    [else (local ((define candidate
                    (find-path (first Os) D G)))
            (cond
              [(boolean? candidate)
               (find-path/list (rest Os) D G)]
              [else candidate]))]))


;; Graph -> Boolean
;; Determines whether there's a path between
;; any pair of nodes.
(check-expect (test-on-all-nodes '()) #true)
(check-expect (test-on-all-nodes '((A))) #true)
(check-expect (test-on-all-nodes '((A B) (B A))) #true)
(check-expect (test-on-all-nodes '((A B C) (B A C) (C B A))) #true)
(check-expect (test-on-all-nodes '((A B C) (B A C))) #false)
(check-expect (test-on-all-nodes '((A B))) #false)
(check-expect (test-on-all-nodes sample-graph) #false)
(check-expect (test-on-all-nodes cyclic-graph) #false)
(define (test-on-all-nodes g)
  (local ((define nodes-number (length g)))
    (andmap (lambda (lon) (= nodes-number (length lon))) g)))

