;; The first three lines of this file were inserted by DrRacket. They record metadata
8;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-261) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 261.
;; Consider the function definition in figure 101.
;; Both clauses in the nested cond expression extract the first item from an-inv
;; and both compute (extract1 (rest an-inv)).
;; Use local to name this expression.
;; Does this help increase the speed at which the function computes its result?
;; Significantly? A little bit? Not at all?


(define-struct ir [name price])
;; An IR is a structure:
;;   (make-ir String Number)

;; An Inventory is one of:
;; – '()
;; – (cons IR Inventory)

(define test-inventory-sm
  (list
   (make-ir "Jostaberry" 0.2)
   (make-ir "Avocado" 1.1)
   (make-ir "Apple" 0.4)))

(define test-inventory
  (list
   (make-ir "Jostaberry" 0.2)
   (make-ir "Avocado" 1.1)
   (make-ir "Apple" 0.4)
   (make-ir "Melon" 2)
   (make-ir "Durian" 20)
   (make-ir "Banana" 0.8)
   (make-ir "Pear" 0.3)
   (make-ir "Cherry" 0.1)
   (make-ir "Watermelon" 1.5)
   (make-ir "Strawberry" 0.1)))

(define test-inventory-lg (append test-inventory test-inventory test-inventory test-inventory))


;; Inventory -> Inventory
;; Creates an Inventory from an-inv for all
;; those items that cost less than a dollar.
(define (extract1 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (cond
       [(<= (ir-price (first an-inv)) 1.0)
        (cons (first an-inv) (extract1 (rest an-inv)))]
       [else (extract1 (rest an-inv))])]))

(define (extract2 an-inv)
  (cond
    [(empty? an-inv) '()]
    [else
     (local ((define extracted (extract2 (rest an-inv))))
       (cond
         [(<= (ir-price (first an-inv)) 1.0)
          (cons (first an-inv) extracted)]
         [else extracted]))]))


;;; Application

;(extract1 test-inventory-sm)

;(extract2 test-inventory-sm)

;(extract1 test-inventory-lg)

;(extract2 test-inventory-lg)


;;; Answer.
;; The performance stays the same.
;; The only difference is the order in which
;; the functions pick or reject the members of the list.
;; extract1 checks members from the left to right of the list.
;; extract2 does the same in the opposite direction:
;; from the rigth to left of the list.

