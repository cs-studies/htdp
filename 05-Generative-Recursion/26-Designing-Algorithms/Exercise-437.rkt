;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-437) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 437.
;; Define solve and combine-solutions so that:


;; special computes the length of its input.
(check-expect (special1 '()) 0)
(check-expect (special1 '(3)) 1)
(check-expect (special1 '(3 2)) 2)
(check-expect (special1 '(3 2 1)) 3)
(define (special1 P)
  (local ((define (solve P) 0)
          (define (combine-solutions P processed)
            (add1 processed)))
    (cond
      [(empty? P) (solve P)]
      [else
       (combine-solutions
        P
        (special1 (rest P)))])))


;; special negates each number on the given list of numbers.
(check-expect (special2 '()) '())
(check-expect (special2 '(3)) '(-3))
(check-expect (special2 '(3 -2)) '(-3 2))
(check-expect (special2 '(3 -2 1)) '(-3 2 -1))
(define (special2 P)
  (local ((define (solve P) '())
          (define (combine-solutions P processed)
            (cons (* -1 (first P)) processed)))
    (cond
      [(empty? P) (solve P)]
      [else
       (combine-solutions
        P
        (special2 (rest P)))])))


;; special uppercases the given list of strings.
(check-expect (special3 '()) '())
(check-expect (special3 '("am")) '("AM"))
(check-expect (special3 '("am" "dog")) '("AM" "DOG"))
(check-expect (special3 '("am" "dog" "cat")) '("AM" "DOG" "CAT"))
(define (special3 P)
  (local ((define (solve P) '())
          (define (combine-solutions P processed)
            (cons (string-upcase (first P)) processed)))
    (cond
      [(empty? P) (solve P)]
      [else
       (combine-solutions
        P
        (special3 (rest P)))])))


;;; What do you conclude from these exercises?
;; This is why abstraction is so useful tool.
;; Structural recursive functions can easily be abstracted out
;; as they follow the same pattern.

