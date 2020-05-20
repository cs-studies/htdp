;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-172) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 172.
;; Design the function collapse, which converts a list of lines into a string.


(require 2htdp/batch-io)


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

;; LLS -> String
;; Converts a list of lines into a string.
(check-expect (collapse lls0) "")
(check-expect (collapse lls1) "hello world\n")
(check-expect (collapse (cons line0 '())) "hello world\n")
(check-expect (collapse lls2) "hello world\nhello world\n")
(define (collapse lls)
  (cond
    [(empty? lls) ""]
    [(cons? lls)
     (string-append (collapse-line (first lls)) (collapse (rest lls)))]))

;; List-of-strings -> String
;; Concatenates the words on the list ln.
(check-expect (collapse-line line0) "hello world\n")
(check-expect (collapse-line line1) "")
(define (collapse-line ln)
  (cond
    [(empty? ln) ""]
    [(cons? ln)
     (string-append (first ln)
                    (if (empty? (rest ln)) "\n" " ")
                    (collapse-line (rest ln)))]))


;;; Application

#|
(write-file "files/ttt.dat"
            (collapse (read-words/line "files/ttt.txt")))
|#

