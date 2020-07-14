;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-274) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 274.
;; Use existing abstractions to define the prefixes and suffixes functions from exercise 190.
;; Ensure that they pass the same tests as the original function.


;; [List-of 1String] -> [List-of [List-of 1String]]
;; Produces a list of all the prefixes of the given list.
(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a" "b") (list "a")))
(check-expect (prefixes (list "a" "b" "c"))
              (list (list "a" "b" "c") (list "a" "b") (list "a")))
(check-expect (prefixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d") (list "a" "b" "c") (list "a" "b") (list "a")))
(define (prefixes l)
  (local ((define l-length (length l))
          (define (wrapper i)
            (local ((define (prefixes j)
                      (list-ref l j)))
              (build-list (- l-length i) prefixes))))
    (build-list l-length wrapper)))

;;; Prefixes Trace Table (top to bottom; left to right)
;; (list "a" "b" "c")
;; l-length:          3
;; i:                 0       1     2
;; (- l-length i):    3       2     1
;; j:                 0 1 2   0 1   0
;; prefixes result:   a b c   a b   a


;; Optional solution based on
;; https://github.com/bgusach/exercises-htdp2e/blob/master/3-abstraction/ex-274.rkt
(check-expect (prefixes2 (list "a" "b")) (list (list "a") (list "a" "b")))
(define (prefixes2 l)
  (local ((define (traverse x y)
            (local ((define (prepend-x i)
                      (cons x i)))
              (map prepend-x (cons '() y)))))
    (foldr traverse '() l)))

;;; Prefixes2 Trace Table (top to bottom; left to right)
;; (list "a" "b")
;; x:                 "b"              "a"
;; y:                 '()              '(("b"))
;; map l:             (cons '() '())   (cons '() '(("b")))
;; map l 2:           '(())           '(() ("b"))
;; i:                 '()              '()                     '("b")
;; prepend-x:         (cons "b" '())   (cons "a" '())          (cons "a" '("b"))
;; map result:        '(("b"))                                '(("a") ("a" "b"))


;; [List-of 1String] -> [List-of [List-of 1String]]
;; Produces a list of all the suffixes of the given list.
(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list "a" "b")) (list (list "a" "b") (list "b")))
(check-expect (suffixes (list "a" "b" "c"))
              (list (list "a" "b" "c") (list "b" "c") (list "c")))
(check-expect (suffixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d") (list "b" "c" "d") (list "c" "d") (list "d")))

(define (suffixes l)
  (local ((define l-length (length l))
          (define (wrapper i)
            (local ((define (suffixes j)
                      (list-ref l (+ j i))))
              (build-list (- l-length i) suffixes))))
    (build-list l-length wrapper)))

;;; Suffixes Trace Table (top to bottom; left to right)
;; (list "a" "b" "c")
;; l-length:          3
;; i:                 0       1     2
;; (- l-length i):    3       2     1
;; j:                 0 1 2   0 1   0
;; suffixes result:   a b c   b c   c

