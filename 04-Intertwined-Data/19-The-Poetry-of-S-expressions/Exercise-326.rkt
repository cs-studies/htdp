;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-326) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 326.
;; Design create-bst.


(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
;; A BST (short for Binary Search Tree) is one of:
;; – NONE
;; – (make-node Number Symbol BST BST)
;; Data invariant:
;; (node-ssn node-left) < node-ssn < (node-ssn node-right)

(define bst10 (make-node 10 'a NONE NONE))
(define bst24 (make-node 24 'b NONE NONE))
(define bst77 (make-node 77 'c NONE NONE))
(define bst99 (make-node 99 'd NONE NONE))
(define bst15 (make-node 15 'e bst10 bst24))
(define bst29 (make-node 29 'f bst15 NONE))
(define bst95 (make-node 95 'g NONE bst99))
(define bst89 (make-node 89 'h bst77 bst95))
(define bst63 (make-node 63 'i bst29 bst89))

;;          63
;;          *
;;        /  \
;;    29 *    * 89
;;      /    / \
;;  15 *    *   * 95
;;    / \  77    \
;;   *   *        *
;;  10   24       99

(define bst89-new
  (make-node 89 'h
             (make-node 77 'c (make-node 75 'z NONE NONE) NONE)
             bst95))


;; BST Number Symbol -> BST
;; Produces a BST that is like bst
;; with one more node insterted.
(check-expect (create-bst NONE 1 'z)
              (make-node 1 'z NONE NONE))
(check-expect (create-bst bst10 9 'z)
              (make-node 10 'a (make-node 9 'z NONE NONE) NONE))
(check-expect (create-bst bst10 11 'z)
              (make-node 10 'a NONE (make-node 11 'z NONE NONE)))
(check-expect (create-bst bst63 75 'z)
              (make-node 63 'i bst29 bst89-new))
(define (create-bst bst n s)
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
               (node-right bst)))]))

