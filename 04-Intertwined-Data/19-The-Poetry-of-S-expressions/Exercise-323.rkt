;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-323) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 323.
;; Design search-bt.
;; The function consumes a number n and a BT.
;; If the tree contains a node structure whose ssn field is n,
;; the function produces the value of the name field in that node.
;; Otherwise, the function produces #false.


(define-struct no-info [])
(define NONE (make-no-info))

(define-struct node [ssn name left right])
;; A BT (short for BinaryTree) is one of:
;; – NONE
;; – (make-node Number Symbol BT BT)

(define bt1
  (make-node
   15
   'd
   NONE
   (make-node
    24 'i NONE NONE)))

(define bt2
  (make-node
   15
   'd
   (make-node
    87 'h NONE NONE)
   NONE))


;; BT Number -> [Maybe Symbol]
;; Produces the name in the node whose ssn field value equals to n.
;; Otherwise produces #false.
(check-expect (search-bt NONE 10) #false)
(check-expect (search-bt bt1 10) #false)
(check-expect (search-bt bt1 15) 'd)
(check-expect (search-bt bt1 24) 'i)
(check-expect (search-bt bt2 24) #false)
(check-expect (search-bt bt2 15) 'd)
(check-expect (search-bt bt2 87) 'h)
(define (search-bt a-tree n)
  (cond
    [(no-info? a-tree) #false]
    [else (if (= n (node-ssn a-tree))
              (node-name a-tree)
              (if (boolean? (search-bt (node-left a-tree) n))
                  (search-bt (node-right a-tree) n)
                  (search-bt (node-left a-tree) n)))]))

