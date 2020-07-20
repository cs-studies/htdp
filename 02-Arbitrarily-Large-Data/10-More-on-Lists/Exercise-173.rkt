;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-173) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 173.
;; Design a program that removes all articles from a text file.
;; The program consumes the name n of a file, reads the file, removes the articles,
;; and writes the result out to a file
;; whose name is the result of concatenating "no-articles-" with n.


(require 2htdp/batch-io)


;;; Data Definitions

;; A List-of-strings is one of:
;; - '()
;; - (cons String List-of-strings)

;; An LLS is one of:
;; – '()
;; – (cons List-of-strings LLS)
;; Represents a list of lines, each is a list of Strings.


;;; Constants

(define FILES-DIR "files")
(define PREPEND-NAME "no-articles-")
(define ARTICLES (cons "a" (cons "an" (cons "the" '()))))
(define PS "/") ; path separator


;;; Test Data
(define line0 (cons "hello" (cons "a" (cons "world" '()))))
(define line1 '())
(define line2 (cons "hello" (cons "an" (cons "world" '()))))
(define line3 (cons "hello" (cons "the" (cons "world" '()))))

(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))
(define lls2 (cons line0 (cons line0 '())))
(define lls3 (cons line0 (cons line1 (cons line2 (cons line3 '())))))


;;; Functions

;; String -> String
;; Saves a file with the text from the file n
;; having all articles removed.
;; Usage: (main "ttt.txt")
(check-expect (main "ttt.txt") (string-append FILES-DIR PS PREPEND-NAME "ttt.txt"))
(define (main n)
  (write-file
   (build-name n)
   (collapse (read-words/line (build-path n)))))

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
;; Concatenates the words - except articles - on the list ln.
(check-expect (collapse-line line0) "hello world\n")
(check-expect (collapse-line line1) "")
(check-expect (collapse-line line2) "hello world\n")
(check-expect (collapse-line line3) "hello world\n")
(define (collapse-line ln)
  (cond
    [(empty? ln) ""]
    [(cons? ln)
     (string-append (if (article? (first ln)) "" (first ln))
                    (if (empty? (rest ln))
                        "\n"
                        (if (article? (first ln)) "" " "))
                    (collapse-line (rest ln)))]))

;; String -> Boolean
;; Identifies articles: a, an, the.
(check-expect (article? "a") #true)
(check-expect (article? "an") #true)
(check-expect (article? "the") #true)
(check-expect (article? "b") #false)
(check-expect (article? "bit") #false)
(define (article? s)
  (member? s (cons "a" (cons "an" (cons "the" '())))))


;;; Application

;(main "ttt.txt")

