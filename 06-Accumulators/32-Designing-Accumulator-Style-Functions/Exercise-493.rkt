;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-493) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 493.
;; Argue that, in the terminology of Intermezzo 5: The Cost of Computation,
;; invert consumes O(n^2) time when the given list consists of n items.


;; [List-of X] -> [List-of X]
;; Constructs the reverse of alox.
(check-expect (invert '(a b c)) '(c b a))
(define (invert alox)
  (cond
    [(empty? alox) '()]
    [else
     (add-as-last (first alox) (invert (rest alox)))]))

;; X [List-of X] -> [List-of X]
;; Adds an-x to the end of alox.
(check-expect (add-as-last 'a '(c b)) '(c b a))
(define (add-as-last an-x alox)
  (cond
    [(empty? alox) (list an-x)]
    [else
     (cons (first alox) (add-as-last an-x (rest alox)))]))

#|
(invert '(a b c))
;==
(add-as-last 'a (invert '(b c)))
;==
(add-as-last 'a (add-as-last 'b (invert '(c))))
;==
(add-as-last 'a (add-as-last 'b (add-as-last 'c (invert '()))))
;==
(add-as-last 'a (add-as-last 'b (add-as-last 'c '())))
;==
(add-as-last 'a (add-as-last 'b '(c)))
;==
(add-as-last 'a (cons 'c (add-as-last 'b '())))
;==
(add-as-last 'a (cons 'c (cons 'b '())))
;==
(add-as-last 'a '(c b))
;==
(cons 'c (add-as-last 'a (cons 'b '())))
;==
(cons 'c (cons 'b (add-as-last 'a '())))
;==
(cons 'c (cons 'b (cons 'a '())))
;==
'(c b a)
|#

;;; Answer
;; invert makes
;; n recursive calls to invert,
;; n calls to add-as-last,
;; and (n - 1) n / 2 recursive calls to add-as-last.
;; Summed up together, the result shows the dominant factor is n^2.
;; Hence, invert takes on the order of n^2 steps
;; where n is the size of the list.

