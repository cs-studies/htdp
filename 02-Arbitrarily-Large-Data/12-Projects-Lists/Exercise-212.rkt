;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-212) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 212.
;; Write down the data definition for List-of-words.
;; Make up examples of Words and List-of-words.
;; Finally, formulate the functional example from above with check-expect.


;; A Word is one of:
;; – '()
;; – (cons 1String Word)
;; Represents a list of 1Strings (letters).

;; A List-of-words is one of:
;; - (cons Word '())
;; - (cons Word List-of-words)


(define W1 '())

(define W2 (cons "a" (cons "m" '())))

(define W3 (cons "d" (cons "o" '())))


(define LW1 (cons '() '()))
(check-expect LW1 (cons W1 '()))
(check-expect LW1 (list W1))

(define LW2 (cons
             (cons "a" (cons "m" '()))
             '()))
(check-expect LW2 (cons W2 '()))
(check-expect LW2 (list W2))

(define LW3 (cons
             (cons "d" (cons "o" '()))
             '()))
(check-expect LW3 (cons W3 '()))
(check-expect LW3 (list W3))

(define LW4 (cons
             (cons "a" (cons "m" '()))
             (cons
              (cons "d" (cons "o" '()))
              '())))
(check-expect LW4 (cons W2 (cons W3 '())))
(check-expect LW4 (cons W2 LW3))
(check-expect LW4 (list (list "a" "m") (list "d" "o")))

