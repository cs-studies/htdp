;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-322) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 322.
;; Draw the above two trees in the manner of figure 119.
;; Then design contains-bt?,
;; which determines whether a given number occurs in some given BT.


(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
;; A BT (short for BinaryTree) is one of:
;; – NONE
;; – (make-node Number Symbol BT BT)

(define t1
  (make-node
   15
   'd
   NONE
   (make-node
    24 'i NONE NONE)))

;;     * 15
;;      \
;;       * 24


(define t2
  (make-node
   15
   'd
   (make-node
    87 'h NONE NONE)
   NONE))

;;     * 15
;;    /
;;   * 87


;; BT Number -> Boolean
;; Determines whether n occurs in the given BT.
(check-expect (contains-bt? NONE 10) #false)
(check-expect (contains-bt? t1 10) #false)
(check-expect (contains-bt? t1 15) #true)
(check-expect (contains-bt? t1 24) #true)
(check-expect (contains-bt? t2 24) #false)
(check-expect (contains-bt? t2 15) #true)
(check-expect (contains-bt? t2 87) #true)
(define (contains-bt? a-tree n)
  (cond
    [(no-info? a-tree) #false]
    [else (or (= n (node-ssn a-tree))
              (contains-bt? (node-left a-tree) n)
              (contains-bt? (node-right a-tree) n))]))

