;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-475) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 475.
;; Redesign the find-path program as a single function.


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
(define (find-path O D G)
  (cond
    [(symbol=? O D) (list D)]
    [else
     (local (
             (define (find-path/list Os D)
               (local ((define (process o r)
                         (local ((define candidate (find-path o D G)))
                           (if (boolean? candidate) r candidate))))
                 (foldr process #false Os)))

             (define (neighbors n g)
               (local ((define found (assoc n g)))
                 (if (false? found) #false (rest found))))

             (define candidate (find-path/list (neighbors O G) D)))
       (cond
         [(boolean? candidate) #false]
         [else (cons O candidate)]))]))

