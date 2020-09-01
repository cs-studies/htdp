;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-421) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 421.
;; Is (bundle '("a" "b" "c") 0) a proper use of the bundle function?
;; What does it produce? Why?


;; [List-of 1String] N -> [List-of String]
;; Bundles chunks of s into strings of length n.
(check-expect (bundle '() 0) '())
(check-expect (bundle '("a" "b") 0) '())
(check-expect (bundle '("a" "b" "c") 0) '())
(check-expect (bundle '() 1) '())
(check-expect (bundle '("a" "b") 1) '("a" "b"))
(check-expect (bundle '() 2) '())
(check-expect (bundle '("a" "b") 2) '("ab"))
(check-expect (bundle '("a" "b") 3) '("ab"))
(check-expect (bundle (explode "abcdefg") 3) '("abc" "def" "g"))
(define (bundle s n)
  (cond
    [(or (zero? n) (empty? s)) '()]
    [else
     (cons (implode (take s n)) (bundle (drop s n) n))]))

; [List-of X] N -> [List-of X]
; keeps the first n items from l if possible or everything
(define (take l n)
  (cond
    [(zero? n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))

; [List-of X] N -> [List-of X]
; removes the first n items from l if possible or everything
(define (drop l n)
  (cond
    [(zero? n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))


;;; Answer.
;; Yes, it is a proper use since the function bundle declares
;; it accepts arguments such as '("a" "b" "c") and 0.
;; With the initial implementation of the function,
;; n equal to 0 causes the function bundle
;; to get into an infinite loop of handling the same arguments
;; because (drop s 0) drops nothing from the list s.
;; To overcome the issue the function
;; mustn't accept arguments that would break it
;; or must handle such arguments specifically.

