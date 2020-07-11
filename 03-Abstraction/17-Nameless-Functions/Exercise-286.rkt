;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-286) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 286.
;; An inventory record specifies
;; - the name of an item,
;; - a description,
;; - the acquisition price,
;; - and the recommended sales price.
;; Define a function that sorts a list of inventory records
;; by the difference between the two prices.


(define-struct ir [name descr bought sell])
;; An IR is a structure:
;;    (make-ir String String Number Number)
;; (make-ir n d p1 p2) represents an inventory record with
;; the name n, description d, acquisition price p1,
;; and the sales price p2.

;; [List-of IR] -> [List-of IR]
;; Sorts the given list by the difference between the two prices.
(check-expect (sort-by-diff '()) '())
(check-expect (sort-by-diff (list (make-ir "Avocado" "Greasy" 1 1.5)
                                  (make-ir "Durian" "Smelly" 20 25)
                                  (make-ir "Apple" "Sweet" 0.1 0.2)))
              (list (make-ir "Apple" "Sweet" 0.1 0.2)
                    (make-ir "Avocado" "Greasy" 1 1.5)
                    (make-ir "Durian" "Smelly" 20 25)))
(define (sort-by-diff l)
  (local (;; IR -> Number
          (define (diff-prices ir)
            (- (ir-sell ir) (ir-bought ir))))
    (sort l (lambda (ir1 ir2) (< (diff-prices ir1) (diff-prices ir2))))))

