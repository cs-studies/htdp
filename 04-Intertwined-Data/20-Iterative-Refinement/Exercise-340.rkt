;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-340) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 340.
;; Design the function ls,
;; which lists the names of all files and directories in a given Dir.


(require htdp/dir)


;; Dir -> [List-of String]
;; Lists the names of all files and directories
;; in the given Dir.
(check-expect (ls (create-dir "../../03-Intermezzo/"))
              '("Exercise-300.rkt"
                "Exercise-301.rkt"
                "Exercise-302.rkt"
                "Exercise-303.rkt"
                "Exercise-304.rkt"
                "Exercise-305.rkt"
                "Exercise-306.rkt"
                "Exercise-307.rkt"
                "Exercise-308.rkt"
                "Exercise-309.rkt"))
(check-expect (ls (create-dir "../../01-Fixed-Size-Data/01-Arithmetic/"))
              '("Exercise-01.rkt"
                "Exercise-02.rkt"
                "Exercise-03.rkt"
                "Exercise-04.rkt"
                "Exercise-05.rkt"
                "Exercise-06.rkt"
                "Exercise-07.rkt"
                "Exercise-08.rkt"
                "Exercise-09.rkt"
                "Exercise-10.rkt"
                "../../01-Fixed-Size-Data/01-Arithmetic/images"
                "cat.png"))

(define (ls d)
  (local ((define (ls-dirs d l)
            (cons (symbol->string (dir-name d))
                  (append (ls d) l))))
    (append
     (map (lambda (f) (file-name f)) (dir-files d))
     (foldr ls-dirs '() (dir-dirs d)))))

