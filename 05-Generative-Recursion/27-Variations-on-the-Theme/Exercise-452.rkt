;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-452) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 452.
;; Both first-line and remove-first-line are missing purpose statements.
;; Articulate proper statements.


;; A File is one of:
;; - '()
;; - (cons "\n" File)
;; - (cons 1String File)

;; A Line is a [List-of 1String]


(define NEWLINE "\n")


;; File -> [List-of Line]
;; Converts a file into a list of lines.
(check-expect (file->list-of-lines '()) '())
(check-expect (file->list-of-lines (list "\n")) (list '()))
(check-expect (file->list-of-lines (list "\n" "\n")) (list '() '()))
(check-expect (file->list-of-lines
               (list "a" "b" "c" "\n"
                     "d" "e" "\n"
                     "f" "g" "h" "\n"))
              (list (list "a" "b" "c")
                    (list "d" "e")
                    (list "f" "g" "h")))
(define (file->list-of-lines afile)
  (cond
    [(empty? afile) '()]
    [else (cons (first-line afile)
                (file->list-of-lines (remove-first-line afile)))]))

;; File -> Line
;; Produces the first line of the file.
(define (first-line afile)
  (cond
    [(empty? afile) '()]
    [(string=? (first afile) NEWLINE) '()]
    [else (cons (first afile) (first-line (rest afile)))]))

;; File -> File
;; Produces a file the same as the given one
;; but without the first line.
(define (remove-first-line afile)
  (cond
    [(empty? afile) '()]
    [(string=? (first afile) NEWLINE) (rest afile)]
    [else (remove-first-line (rest afile))]))

