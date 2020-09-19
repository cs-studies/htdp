;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-485) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 485.
;; A number tree is either a number or a pair of number trees.
;; Design sum-tree, which determines the sum of the numbers in a tree.


;; A Tree is one of:
;; - Number
;; - (list Tree Tree)


(define tree-0 10) ; 0 recursive steps

(define tree-1 (list 10 20)) ; 2 recursive steps

(define tree-2 (list 1 (list (list 2 4) 3))) ; 6 recursive steps

(define tree-3 (list (list 1 5) (list (list 2 4) 3))) ; 8 recursive steps


;; Tree -> Number
;; Determines the sum of the numbers in t.
(check-expect (sum-tree tree-0) 10)
(check-expect (sum-tree tree-1) 30)
(check-expect (sum-tree tree-2) 10)
(check-expect (sum-tree tree-3) 15)
(define (sum-tree t)
  (cond
    [(number? t) t]
    [else (+ (sum-tree (first t))
             (sum-tree (second t)))]))


;;; What is its abstract running time?
;; The program requires two recursive steps per one list item.
;; Hence the program takes on the order of n steps (more precisely, 2n steps)
;; on a tree with n pairs of numbers.

;;; What is an acceptable measure of the size of such a tree?
;; A quantaty of numbers or pairs on the tree.

;;; What is the worst possible shape of the tree?
;; A tree consisting of a large quantity of numbers grouped by pairs. 

;;; What’s the best possible shape?
;; A tree consisting of one number.

