;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-175) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 175.
;; Design a BSL program that simulates the Unix command wc.


(require 2htdp/batch-io)


(define-struct info [lines words chars])
;; An Info is a structure
;;  (make-info Number Number Number)
;; (make-info l w c) represents an information about a file
;; with l lines, w words, and c characters.



;;;; Solution 1.

;; String -> Info
;; Counts the number of lines, words, and characters in the given file.
(check-expect (wc-short "files/ttt.txt") (make-info 13 33 184))
(define (wc-short filename)
  (make-info
   (length (read-lines filename))
   (length (read-words filename))
   (add1 (length (read-1strings filename))))) ; plus the last newline character



;;;; Solution 2.

;;; Data Definitions

;; A List-of-strings is one of:
;; - '()
;; - (cons String List-of-strings)

;; An LLS is one of:
;; – '()
;; – (cons List-of-strings LLS)
;; Represents a list of lines, each is a list of Strings.


;;; Test Data

(define line0 (cons "hello" (cons "world" '())))
(define line1 '())

(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))
(define lls2 (cons line0 (cons line0 '())))


;;; Functions

;; String -> Info
;; Counts the number of lines, words, and characters in the given file.
(check-expect (wc-recursive "files/ttt.txt") (make-info 13 33 184))
(define (wc-recursive filename)
  (count-all (read-words/line filename)))

;; LLS -> Info
;; Counts the number of lines, words, and characters on the list.
(check-expect (count-all lls0) (make-info 0 0 0))
(check-expect (count-all lls1) (make-info 2 2 13))
(check-expect (count-all lls2) (make-info 2 4 24))
(define (count-all lls)
    (make-info (length lls) (count-words lls) (count-chars lls)))

;; LLS -> Number
;; Counts the number of words on the list.
(check-expect (count-words lls0) 0)
(check-expect (count-words lls1) 2)
(check-expect (count-words lls2) 4)
(define (count-words lls)
  (cond
    [(empty? lls) 0]
    [(cons? lls) (+ (length (first lls)) (count-words (rest lls)))]))

;; LLS -> Number
;; Counts the number of characters on the list.
(check-expect (count-chars lls0) 0)
(check-expect (count-chars lls1) 13)
(check-expect (count-chars lls2) 24)
(define (count-chars lls)
  (cond
    [(empty? lls) 0]
    [(cons? lls) (+ (if (empty? (first lls)) 1 0) ; empty line
                    (count-chars-line (first lls))
                    (count-chars (rest lls)))]))

;; List-of-strings -> Number
;; Counts the number of characters on the list.
(check-expect (count-chars-line line0) 12)
(check-expect (count-chars-line line1) 0)
(define (count-chars-line ln)
  (cond
    [(empty? ln) 0]
    [(cons? ln) (+
                 1 ; space between words
                 (string-length (first ln))
                 (count-chars-line (rest ln)))]))


;;; Application

;(wc-short "files/ttt.txt")
;(wc-recursive "files/ttt.txt")

