;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-336) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 336.
;; Design the function how-many,
;; which determines how many files a given Dir contains.


(define-struct file [name size content])
;; A File is a structure:
;;   (make-file String N String)

;; A File* is one of:
;; - '()
;; - (cons File File*)

(define-struct dir [name dirs files])
;; A Dir is a structure:
;;    (make-dir String Dir* File*)

;; A Dir* is one of:
;; - '()
;; - (cons Dir Dir*)


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
;; This solution follows structural design recipe.
;; See alternative solutions in the exercise 337.
(check-expect (how-many Dir-Empty) 0)
(check-expect (how-many (make-dir "No Files" (list Dir-Empty) '())) 0)
(check-expect (how-many Dir-Docs) 1)
(check-expect (how-many Dir-Text) 3)
(check-expect (how-many Dir-Libs) 3)
(check-expect (how-many Dir-TS) 7)
(define (how-many d)
  (local (;; File* -> Number
          (define (how-many-in-files lof)
            (length lof))
          ;; Dir* -> Number
          (define (how-many-in-dirs lod)
            (cond
              [(empty? lod) 0]
              [else (+
                     (how-many-in-files (dir-files (first lod)))
                     (how-many-in-dirs (dir-dirs (first lod)))
                     (how-many-in-dirs (rest lod)))])))
    (+
     (how-many-in-files (dir-files d))
     (how-many-in-dirs (dir-dirs d)))))

