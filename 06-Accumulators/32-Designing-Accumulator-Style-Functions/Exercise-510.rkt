;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-510) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 510.
;; Design the program fmt.
;; It consumes a natural number w, the name of an input file in-f,
;; and the name of an output file out-f
;; in the same sense as read-file from the 2htdp/batch-io library.
;; Its purpose is to read all the words from the in-f,
;; to arrange these words in the given order into lines of maximal width w,
;; and to write these lines to out-f.


(require 2htdp/batch-io)


;; N is one of:
;; - 0
;; - (add1 N)


;; N String String -> Boolean
;; Reads all the words from the in-f,
;; arranges them into lines of maximal width w,
;; and writes the lines to out-f.
(define (fmt w in-f out-f)
  (if (file-exists? in-f)
      (write-file out-f (fmt* w (read-1strings in-f)))
      (error "Input file not found")))

;; N [List-of 1String] -> String
;; Arranges 1Strings into String with newlines
;; placed each w 1Strings.
(check-expect (fmt* 3 '()) "")
(check-expect (fmt* 3 '("a")) "a")
(check-expect (fmt* 3 (explode "abc")) "abc\n")
(check-expect (fmt* 3 (explode "abcd")) "abc\nd")
(check-expect (fmt* 3 (explode "abc\nd")) "abc\nd")
(check-expect (fmt* 3 (explode "ab\ncdefg\n")) "abc\ndef\ng")
(define (fmt* w l0)
  (local (;; [List-of 1String] String N -> String
          ;; Accumulator str is a string that contains
          ;; chars from l0 that are not on l.
          ;; count keeps track of a number of chars on a line.
          (define (fmt/acc l str count)
            (cond
              [(empty? l) str]
              [else
               (local ((define is-newline? (= count w))
                       (define ch (first l))
                       (define omit-char? (string=? "\n" ch))
                       (define next-count
                         (cond
                           [omit-char? count]
                           [is-newline? 1]
                           [else (add1 count)])))
                 (fmt/acc (rest l)
                          (if omit-char?
                              str
                              (if is-newline?
                                  (string-append str ch "\n")
                                  (string-append str ch)))
                          next-count))])))
    (fmt/acc l0 "" 1)))


;;; Application

;(fmt 40 "./files/510.txt" "./files/formatted.txt")

