;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-190) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 190.
;; Design the prefixes function,
;; which consumes a list of 1Strings and produces the list of all prefixes.
;; Design the function suffixes,
;; which consumes a list of 1Strings and produces all suffixes.


;;; Data Definitions

;; A List-of-1strings is one of:
;; - '()
;; - (cons 1String List-of-1strings)

;; A List-of-prefixes is one of:
;; - '()
;; - (cons List-of-1strings List-of-prefixes)
;; Contstaint: a list p is a prefix of l
;; if p and l are the same up through all items in p.
;; For example, (list "a" "b" "c") is a prefix of itself and (list "a" "b" "c" "d").

;; A List-of-suffixes is one of:
;; - '()
;; - (cons List-of-1strings List-of-suffixes)
;; Contstaint: A list s is a suffix of l
;; if p and l are the same from the end,
;; up through all items in s.
;; For example, (list "b" "c" "d") is a suffix of itself and (list "a" "b" "c" "d").


;;; Functions

;; List-of-1strings -> List-of-prefixes
;; Produces a list of all the prefixes of the given list.
(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b")) (list (list "a" "b") (list "a")))
(check-expect (prefixes (list "a" "b" "c"))
              (list (list "a" "b" "c") (list "a" "b") (list "a")))
(check-expect (prefixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d") (list "a" "b" "c") (list "a" "b") (list "a")))
(define (prefixes l)
  (cond
    [(empty? l) '()]
    [else (append (list l) (prefixes (remove-last l)))]))

;; List-of-1strings -> List-of-1strings
;; Produces a list like the given one, without the last element.
(check-expect (remove-last '()) '())
(check-expect (remove-last (list "a")) '())
(check-expect (remove-last (list "a" "b")) (list "a"))
(check-expect (remove-last (list "a" "b" "c")) (list "a" "b"))
(define (remove-last l)
  (cond
    [(or (empty? l) (empty? (rest l))) '()]
    [else (cons (first l) (remove-last (rest l)))]))


;; List-of-1strings -> List-of-suffixes
;; Produces a list of all the suffixes of the given list.
(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a")) (list (list "a")))
(check-expect (suffixes (list "a" "b")) (list (list "a" "b") (list "b")))
(check-expect (suffixes (list "a" "b" "c"))
              (list (list "a" "b" "c") (list "b" "c") (list "c")))
(check-expect (suffixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d") (list "b" "c" "d") (list "c" "d") (list "d")))
(define (suffixes l)
  (cond
    [(empty? l) '()]
    [else (append (list l) (suffixes (rest l)))]))

