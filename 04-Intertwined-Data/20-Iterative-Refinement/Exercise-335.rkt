;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-335) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 335.
;; Translate the directory tree in figure 123
;; into a data representation according to model 3.
;; Use "" for the content of files.


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


(check-expect
 Dir-TS
 (make-dir
  "TS"
  (list
   (make-dir
    "Text"
    '()
    (list
     (make-file "part1" 99 "")
     (make-file "part2" 52 "")
     (make-file "part3" 17 "")))
   (make-dir
    "Libs"
    (list
     (make-dir
      "Code"
      '()
      (list
       (make-file "hang" 8 "")
       (make-file "draw" 2 "")))
     (make-dir
      "Docs"
      '()
      (list
       (make-file "read!" 19 ""))))
    '()))
  (list
   (make-file "read!" 10 ""))))

