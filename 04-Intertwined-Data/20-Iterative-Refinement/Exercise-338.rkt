;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-338) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 338.
;; Use create-dir to turn some of your directories
;; into ISL+ data representations.
;; Then use how-many from exercise 336
;; to count how many files they contain.
;; Why are you confident that how-many
;; produces correct results for these directories?


(require htdp/dir)


(check-expect (how-many (create-dir "../../03-Intermezzo/")) 10)
(check-expect (how-many (create-dir "../../01-Fixed-Size-Data/01-Arithmetic/")) 11)
(define (how-many d)
     (foldr
      (lambda (d sum) (+ (how-many d) sum))
      (length (dir-files d))
      (dir-dirs d)))


;;; Answer.
;; This number of files is easy to verify by counting them in the file system.
;; Moreover, the function was tested before.

