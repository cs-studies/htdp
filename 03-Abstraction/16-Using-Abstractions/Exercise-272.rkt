;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-272) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 272.
;; Use foldr to define append-from-fold.
;; What happens if you replace foldr with foldl?
;;
;; Now use one of the fold functions to define functions
;; that compute the sum and the product, respectively, of a list of numbers.
;;
;; With one of the fold functions,
;; you can define a function that horizontally composes a list of Images.
;; Can you use the other fold function?
;; Also define a function that stacks a list of images vertically.


(require 2htdp/image)


;; [X Y] [List-of X] [List-of X] -> [List-of X]
;; Combines two lists into one.
(check-expect (append-from-fold '(1) '(3)) '(1 3))
(check-expect (append-from-fold '(1 2) '(2 3)) '(1 2 2 3))
(define (append-from-fold l1 l2)
  (foldr cons l2 l1))

;;; Answer 1
;; Using foldl, the first list members
;; appear on the resulting list in a reversed order.
(check-expect (append-from-foldl '(1 2 3) '(4 5)) '(3 2 1 4 5))
(define (append-from-foldl l1 l2)
  (foldl cons l2 l1))


;; [NEList-of Number] -> Number
;; Computes the sum of the numbers on the list.
(check-expect (sum-from-fold '(1)) 1)
(check-expect (sum-from-fold '(1 2)) 3)
(check-expect (sum-from-fold '(1 2 3)) 6)
(define (sum-from-fold lon)
  (foldl + 0 lon))

;; [NEList-of Number] -> Number
;; Computes the product of the numbers on the list.
(check-expect (product-from-fold '(1)) 1)
(check-expect (product-from-fold '(1 2)) 2)
(check-expect (product-from-fold '(1 2 3)) 6)
(define (product-from-fold lon)
  (foldl * 1 lon))

;; [List-of Image] -> Image
;; Composes a list of images horizontally.
(check-expect (images-horizontally (list (circle 5 "solid" "red") (circle 10 "solid" "blue")))
              (beside (circle 5 "solid" "red") (circle 10 "solid" "blue")))
(define (images-horizontally loi)
  (foldr beside empty-image loi))

;;; Answer 2
;; Yes, any foldl or foldr can be used to compose a list of images.
;; Only the order in which the images are placed changes.

;; [List-of Image] -> Image
;; Composes a list of images vertically.
(check-expect (images-vertically
               (list (circle 5 "solid" "red")
                     (circle 10 "solid" "blue")
                     (circle 7 "outline" "green")))
              (above (circle 5 "solid" "red")
                     (circle 10 "solid" "blue")
                     (circle 7 "outline" "green")))
(define (images-vertically loi)
  (foldr above empty-image loi))

