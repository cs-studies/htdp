;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-327) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 327.
;; Design the function create-bst-from-list.


(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
;; A BST (short for Binary Search Tree) is one of:
;; – NONE
;; – (make-node Number Symbol BST BST)
;; Data invariant:
;; (node-ssn node-left) < node-ssn < (node-ssn node-right)

(define bst10 (make-node 10 'h NONE NONE))
(define bst24 (make-node 24 'i NONE NONE))
(define bst77 (make-node 77 'l NONE NONE))
(define bst99 (make-node 99 'o NONE NONE))
(define bst15 (make-node 15 'd bst10 bst24))
(define bst29 (make-node 29 'b bst15 NONE))
(define bst95 (make-node 95 'g NONE bst99))
(define bst89 (make-node 89 'c bst77 bst95))
(define bst63 (make-node 63 'a bst29 bst89))

;;          63
;;          *
;;        /  \
;;    29 *    * 89
;;      /    / \
;;  15 *    *   * 95
;;    / \  77    \
;;   *   *        *
;;  10   24       99

(define test-l '((99 o)
                 (77 l)
                 (24 i)
                 (10 h)
                 (95 g)
                 (15 d)
                 (89 c)
                 (29 b)
                 (63 a)))


;; [List-of [List Number Symbol]] -> BST
;; Produces BST by repeatedly applying create-bst.
(check-expect (create-bst-from-list '()) NONE)
(check-expect (create-bst-from-list '((63 a)))
              (make-node 63 'a NONE NONE))
(check-expect (create-bst-from-list '((29 b) (63 a)))
              (make-node 63 'a (make-node 29 'b NONE NONE) NONE))
(check-expect (create-bst-from-list '((89 c) (29 b) (63 a)))
              (make-node 63 'a (make-node 29 'b NONE NONE) (make-node 89 'c NONE NONE)))
(check-expect (create-bst-from-list test-l) bst63)
(define (create-bst-from-list l)
  (local ((define (create-bst bst n s)
            (cond
              [(no-info? bst) (make-node n s NONE NONE)]
              [else (make-node
                     (node-ssn bst)
                     (node-name bst)
                     (if (< n (node-ssn bst))
                         (create-bst (node-left bst) n s)
                         (node-left bst))
                     (if (> n (node-ssn bst))
                         (create-bst (node-right bst) n s)
                         (node-right bst)))])))
    (cond
      [(empty? l) NONE]
      [else (create-bst
             (create-bst-from-list (rest l))
             (first (first l))
             (second (first l)))])))

