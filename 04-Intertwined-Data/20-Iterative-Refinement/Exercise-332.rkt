;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-332) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 332.
;; Translate the directory tree in figure 123
;; into a data representation according to model 2.


;; A File is a String.

;; An LOFD (short for list of files and directories) is one of:
;; – '()
;; – (cons File LOFD)
;; – (cons Dir LOFD)

(define-struct dir [name content])
;; A Dir is a structure:
;;   (make-dir String LOFD)


(define Dir-Text
  (make-dir "Text" (cons "part1" (cons "part2" (cons "part3" '())))))

(define Dir-Code
  (make-dir "Code" (cons "hang" (cons "draw" '()))))

(define Dir-Docs
  (make-dir "Docs" (cons "read!" '())))

(define Dir-Libs
  (make-dir "Libs" (cons Dir-Code (cons Dir-Docs '()))))

(define Dir-TS
  (make-dir "TS" (cons Dir-Text (cons "read!" (cons Dir-Libs '())))))

(check-expect
 Dir-TS
 (make-dir "TS"
           (list
            (make-dir "Text"
                      (list "part1" "part2" "part3"))
            "read!"
            (make-dir "Libs"
                      (list
                       (make-dir "Code"
                                 (list "hang" "draw"))
                       (make-dir "Docs" (list "read!")))))))

