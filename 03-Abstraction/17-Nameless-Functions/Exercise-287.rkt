;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-287) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 287.
;; Define filter to define eliminate-expensive.
;; The function consumes a number, ua, and a list of inventory records,
;; and it produces a list of all those structures whose sales price is below ua.
;;
;; Then use filter to define recall,
;; which consumes the name of an inventory item, called ty,
;; and a list of inventory records
;; and which produces a list of inventory records that do not use the name ty.
;;
;; In addition, define selection,
;; which consumes two lists of names
;; and selects all those from the second one that are also on the first.


(define-struct ir [name price])
;; An IR is a structure:
;;   (make-ir String Number)

(define test-inventory
  (list
   (make-ir "Jostaberry" 0.2)
   (make-ir "Avocado" 1.1)
   (make-ir "Apple" 0.6)
   (make-ir "Melon" 2)
   (make-ir "Durian" 20)
   (make-ir "Banana" 0.8)
   (make-ir "Pear" 0.7)
   (make-ir "Cherry" 0.1)
   (make-ir "Watermelon" 1.5)
   (make-ir "Strawberry" 0.1)))

(define test-inventory-sm
  (list
   (make-ir "Jostaberry" 0.2)
   (make-ir "Avocado" 1.1)
   (make-ir "Apple" 0.4)))


;; Number [List-of IR] -> [List-of IR]
;; Produces a list of all the inventory records,
;; whose price is below ua.
(check-expect (eliminate-expensive 0.5 test-inventory)
              (list (make-ir "Jostaberry" 0.2) (make-ir "Cherry" 0.1) (make-ir "Strawberry" 0.1)))
(define (eliminate-expensive ua l)
    (filter (lambda (ir) (< (ir-price ir) ua)) l))


;; String [List-of IR] -> [List-of IR]
;; Produces a list of all inventory records
;; that do not use the name ty.
(check-expect (recall "Avocado" test-inventory-sm)
              (list (make-ir "Jostaberry" 0.2) (make-ir "Apple" 0.4)))
(define (recall ty l)
    (filter (lambda (ir) (not (string=? (ir-name ir) ty))) l))


(define names-1 '("Jane" "John" "Malcolm"))
(define names-2 '("David" "Ned" "John" "Ada" "Jane"))

;; [List-of String] [List-of String] -> [List-of String]
;; Selects strings that belong to the both lists.
(check-expect (selection names-1 names-2) '("John" "Jane"))
(define (selection l1 l2)
    (filter (lambda (name) (member? name l1)) l2))

