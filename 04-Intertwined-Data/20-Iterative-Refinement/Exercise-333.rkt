;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-333) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 333.
;; Design the function how-many,
;; which determines how many files a given Dir contains.


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


;; Dir -> Number
;; Determines how many files a given Dir contains.
(check-expect (how-many (make-dir "Empty" '())) 0)
(check-expect (how-many Dir-Docs) 1)
(check-expect (how-many Dir-TS) 7)
(define (how-many d)
  (local ((define (how-many-lofd l)
            (cond
              [(empty? l) 0]
              [else (+ (if (dir? (first l))
                           (how-many-lofd (dir-content (first l)))
                           1)
                       (how-many-lofd (rest l)))])))
    (how-many-lofd (dir-content d))))

