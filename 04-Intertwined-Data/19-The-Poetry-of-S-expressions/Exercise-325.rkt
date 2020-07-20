;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-325) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 325.
;; Design search-bst.


(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
;; A BST (short for Binary Search Tree) is one of:
;; – NONE
;; – (make-node Number Symbol BST BST)
;; Data invariant:
;; (node-ssn node-left) < node-ssn < (node-ssn node-right)

(define bst1 (make-node 1 'a NONE NONE))
(define bst3 (make-node 3 'b NONE NONE))
(define bst5 (make-node 5 'c NONE NONE))
(define bst2 (make-node 2 'd bst1 bst3))
(define bst4 (make-node 4 'e bst2 bst5))

;;          4
;;          *
;;        /  \
;;     2 *    * 5
;;      / \
;;     *   *
;;    1    3


;; BST Number -> [Maybe Symbol]
;; If bst contains a node whose ssn field is n,
;; produces the value of the name field.
;; Otherwise produces NONE.
(check-expect (search-bst bst4 10) NONE)
(check-expect (search-bst bst4 3) 'b)
(define (search-bst bst n)
  (cond
    [(no-info? bst) NONE]
    [else (cond
            [(= (node-ssn bst) n) (node-name bst)]
            [(> (node-ssn bst) n) (search-bst (node-left bst) n)]
            [else (search-bst (node-right bst) n)])]))

