;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-174) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 174.
;; Design a program that encodes text files numerically.
;; Each letter in a word should be encoded as a numeric three-letter string
;; with a value between 0 and 256.


(require 2htdp/batch-io)


;;; Data Definitions

;; A List-of-strings is one of:
;; - '()
;; - (cons String List-of-strings)

;; An LLS is one of:
;; – '()
;; – (cons List-of-strings LLS)
;; Represents a list of lines, each is a list of Strings.

;; A List-of-1strings is one of:
;; - '()
;; - (cons 1String List-of-1strings)


;;; Constants

(define FILES-DIR "files")
(define PREPEND-NAME "encoded-")
(define PS "/") ; path separator


;;; Test Data

(define line0 (cons "hello" (cons "world" '())))
(define line1 '())

(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))
(define lls2 (cons line0 (cons line0 '())))

(define line0-encoded "104101108108111 119111114108100\n")
(define lls2-encoded (string-append line0-encoded line0-encoded))


;;; Functions

;; String -> String
;; Saves a file with the text from the file n encoded numerically using ASCII.
;; Usage: (main "ttt.txt")
(check-expect (main "ttt.txt") (string-append FILES-DIR PS PREPEND-NAME "ttt.txt"))
(define (main n)
  (write-file
   (build-name n)
   (encode (read-words/line (build-path n)))))

;; String -> String
;; Forms a new file name.
(check-expect (build-name "name.dat") (string-append FILES-DIR PS PREPEND-NAME "name.dat"))
(define (build-name n)
    (build-path (string-append PREPEND-NAME n)))

;; String -> String
;; Forms a path to the file.
(check-expect (build-path "name.dat") (string-append FILES-DIR PS "name.dat"))
(define (build-path n)
  (string-append FILES-DIR PS n))

;; LLS -> String
;; Converts a list of lines into an numerically encoded string,
;; preserving lines and words organization.
(check-expect (encode lls0) "")
(check-expect (encode lls1) line0-encoded)
(check-expect (encode lls2) lls2-encoded)
(define (encode lls)
  (cond
    [(empty? lls) ""]
    [(cons? lls)
     (string-append (encode-line (first lls)) (encode (rest lls)))]))

;; List-of-strings -> String
;; Converts a list of words into an numerically encoded string,
;; preserving words separation.
(check-expect (encode-line line0) line0-encoded)
(check-expect (encode-line line1) "")
(define (encode-line ln)
  (cond
    [(empty? ln) ""]
    [(cons? ln)
     (string-append (encode-word (explode (first ln)))
                    (if (empty? (rest ln)) "\n" " ")
                    (encode-line (rest ln)))]))

;; List-of-1strings -> String
;; Converts a list of 1Strings into a numerically encoded word.
(check-expect (encode-word (cons "A" (cons "B" (cons "C" '())))) "065066067")
(check-expect (encode-word (cons "x" (cons "y" (cons "z" '())))) "120121122")
(define (encode-word lw)
  (cond
    [(empty? lw) ""]
    [else (string-append (encode-letter (first lw)) (encode-word (rest lw)))]))

;; 1String -> String
;; Converts the given 1String to a 3-letter numeric String.
(check-expect (encode-letter "z") (code1 "z"))
(check-expect (encode-letter "\t") (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a") (string-append "0" (code1 "a")))
(define (encode-letter s)
  (cond
    [(>= (string->int s) 100) (code1 s)]
    [(< (string->int s) 10)
     (string-append "00" (code1 s))]
    [(< (string->int s) 100)
     (string-append "0" (code1 s))]))

;; 1String -> String
;; Converts the given 1String into a String.
(check-expect (code1 "z") "122")
(define (code1 c)
  (number->string (string->int c)))


;;; Application

;(main "ttt.txt")

