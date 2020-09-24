;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-502) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 502.
;; Design the function palindrome,
;; which accepts a non-empty list and constructs a palindrome
;; by mirroring the list around the last item.


;;; Solution designed by function composition

;; [X] [NEList-of X] -> [NEList-of X]
;; Creates a palindrome from s0.
(check-expect (mirror (explode "abc")) (explode "abcba"))
(define (mirror s0)
  (local ((define without-last (all-but-last s0)))
    (append without-last
            (list (last s0))
            (reverse without-last))))

;; [X] [NEList-of X] -> [NEList-of X]
;; Removes the last item from the list.
(check-expect (all-but-last '(1)) '())
(check-expect (all-but-last '(3 2 1)) '(3 2))
(define (all-but-last l)
  (cond
    [(empty? (rest l)) '()]
    [else (cons (first l) (all-but-last (rest l)))]))

;; [X] [NEList-of X] -> X
;; Returns the last item on the list.
(check-expect (last '(10)) 10)
(check-expect (last '(1 2 3)) 3)
(define (last l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (last (rest l))]))


;;; Accumulator-style function

;; [X] [NEList-of X] -> [NEList-of X]
;; Constructs a palindrome by mirroring the list
;; around the last item.
(check-expect (palindrome '(1 2)) '(1 2 1))
(check-expect (palindrome '(1 2 3)) '(1 2 3 2 1))
(check-expect (palindrome (explode "abc")) (explode "abcba"))
(define (palindrome l0)
  (local (;; [X] [NEList-of X] [List-of X] -> [NEList-of X]
          ;; Constructs a palindrome.
          ;; Accumulator a is a reversed list of items
          ;; that are on l0 but not on l,
          ;; except the last item of both l0 and l.
          (define (palindrome/acc l a)
            (local ((define f (first l)))
              (cond
                [(empty? (rest l)) (cons f a)]
                [else (cons f (palindrome/acc (rest l) (cons f a)))]))))
    (palindrome/acc l0 '())))

