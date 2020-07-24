;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-341) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 341.
;; Design du, a function that consumes a Dir
;; and computes the total size of all the files
;; in the entire directory tree.
;; Assume that storing a directory in a Dir structure
;; costs 1 file storage unit.


(require 2htdp/abstraction)


(define-struct file [name size content])
;; A File is a structure:
;;   (make-file String N String)

(define-struct dir [name dirs files])
;; A Dir is a structure:
;;    (make-dir String [List-of Dir] [List-of File])


(define Dir-Text
  (make-dir "Text"
            '()
            (list
             (make-file "part1" 99 "")
             (make-file "part2" 52 "")
             (make-file "part3" 17 ""))))

(define Dir-Code
  (make-dir "Code"
            '()
            (list
             (make-file "hang" 8 "")
             (make-file "draw" 2 ""))))

(define Dir-Docs
  (make-dir "Docs"
            '()
            (list
             (make-file "read!" 19 ""))))

(define Dir-Libs
  (make-dir "Libs"
            (list Dir-Code Dir-Docs)
            '()))

(define Dir-TS
  (make-dir "TS"
            (list Dir-Text Dir-Libs)
            (list
             (make-file "read!" 10 ""))))

(define Dir-Empty (make-dir "Empty" '() '()))


;; Dir -> Number
;; Computes the total size of all files
;; in the entire directory tree.
(check-expect (du Dir-Empty) 0)
(check-expect (du Dir-TS) (+ 207 4))
(define (du d)
  (+
   (for/sum ([f (dir-files d)]) (file-size f))
   (for/sum ([d (dir-dirs d)]) (add1 (du d)))))

