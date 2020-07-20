;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-324) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 324.
;; Design the function inorder.
;; It consumes a binary tree
;; and produces the sequence of all the ssn numbers in the tree
;; as they show up from left to right when looking at a tree drawing.


(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
;; A BT (short for BinaryTree) is one of:
;; – NONE
;; – (make-node Number Symbol BT BT)

(define bt15 (make-node 15 'a NONE NONE))
(define bt24 (make-node 24 'b NONE NONE))
(define bt89 (make-node 89 'c NONE NONE))
(define bt29 (make-node 29 'd bt15 bt24))
(define bt63 (make-node 63 'e bt29 bt89))

;;          63
;;          *
;;        /  \
;;    29 *    * 89
;;      / \
;;     *   *
;;    15   24



;; BT -> [List-of Number]
;; Produces the sequence of all the ssn numbers
;; as they show up from left to right in the given BT.
(check-expect (inorder NONE) '())
(check-expect (inorder bt24) '(24))
(check-expect (inorder (make-node 66 's bt89 NONE)) '(89 66))
(check-expect (inorder (make-node 66 's NONE bt24)) '(66 24))
(check-expect (inorder (make-node 66 's bt89 bt24)) '(89 66 24))
(check-expect (inorder bt63) '(15 29 24 63 89))
(define (inorder bt)
  (cond
    [(no-info? bt) '()]
    [else (append
           (inorder (node-left bt))
           (list (node-ssn bt))
           (inorder (node-right bt)))]))


;;; Answer.
;; For a binary search tree,
;; inorder produces a list of ordered numbers.

