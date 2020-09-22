;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-492) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 492.
;; Modify the definitions in figure 169
;; so that the program produces #false,
;; even if it encounters the same origin twice.


;; A Node is a Symbol.

;; A Connection is a list of two items:
;;   (list Node Node)

;; A SimpleGraph is a [List-of Connection]

;; A Graph is a [List-of [List-of Node]].

;; A Path is a [List-of Node].


(define a-sg
  '((A B)
    (B C)
    (C E)
    (D E)
    (E B)
    (F F)))

(define cyclic-graph
  '((A B E)
    (B E F)
    (C B D)
    (D)
    (E C F)
    (F D G)
    (G)))

(define ERR-NOT-NODE "neighbor: not a node")


;; Node Node SimpleGraph -> Boolean
;; Determines whether a path from o to d exists in the sg.
(check-expect (path-exists? 'A 'E a-sg) #true)
(check-expect (path-exists? 'A 'F a-sg) #false)
(define (path-exists? o d sg)
  (local ((define (path-exists?/acc o seen)
            (cond
              [(symbol=? o d) #true]
              [(member? o seen) #false]
              [else (path-exists?/acc (neighbor o sg)
                                      (cons o seen))])))
    (path-exists?/acc o '())))

;; Node SimpleGraph -> Node
;; Determines the node that is connected to a-node in sg.
(check-expect (neighbor 'A a-sg) 'B)
(check-error (neighbor 'G a-sg) ERR-NOT-NODE)
(define (neighbor a-node sg)
  (cond
    [(empty? sg) (error ERR-NOT-NODE)]
    [else
     (local ((define f (first sg)))
       (if (symbol=? (first f) a-node)
           (second f)
           (neighbor a-node (rest sg))))]))


;; Node Node Graph -> [Maybe Path]
;; Finds a path from origination to destination in G.
;; If there is no path, the function produces #false.
(check-expect (find-path 'C 'D cyclic-graph) '(C D))
(check-expect (find-path 'C 'G cyclic-graph) #false)
(define (find-path O D G)
  (local ((define (find-path/acc O seen)
            (cond
              [(symbol=? O D) (list D)]
              [(member? O seen) #false]
              [else
               (local
                 ((define (find-path/list Os D)
                    (cond
                      [(empty? Os) #false]
                      [else
                       (local
                         ((define o (first Os))
                          (define candidate
                            (find-path/acc o (cons o seen))))
                         (cond
                           [(boolean? candidate) (find-path/list (rest Os) D)]
                           [else candidate]))]))

                  (define (neighbors n g)
                    (local ((define found (assoc n g)))
                      (if (false? found) #false (rest found))))

                  (define candidate (find-path/list (neighbors O G) D)))

                 (cond
                   [(boolean? candidate) #false]
                   [else (cons O candidate)]))])))

    (find-path/acc O '())))

