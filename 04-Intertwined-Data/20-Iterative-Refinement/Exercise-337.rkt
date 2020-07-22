;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-337) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 337.
;; Use List-of to simplify the data definition Dir.
;; Then use ISL+’s list-processing functions from figures 95 and 96
;; to simplify the function definition(s) for the solution of exercise 336.


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
;; Determines how many files a given Dir contains.
(check-expect (how-many Dir-Empty) 0)
(check-expect (how-many (make-dir "No Files" (list Dir-Empty) '())) 0)
(check-expect (how-many Dir-Docs) 1)
(check-expect (how-many Dir-Text) 3)
(check-expect (how-many Dir-Libs) 3)
(check-expect (how-many Dir-TS) 7)
(define (how-many d)
     (foldr
      (lambda (d sum) (+ (how-many d) sum))
      (length (dir-files d))
      (dir-dirs d)))

;; This solution uses for/sum abstraction.
(require 2htdp/abstraction)
(check-expect (how-many-for-sum Dir-Empty) 0)
(check-expect (how-many-for-sum Dir-TS) 7)
(define (how-many-for-sum d)
    (+
     (length (dir-files d))
     (for/sum ([d (dir-dirs d)]) (how-many d))))

