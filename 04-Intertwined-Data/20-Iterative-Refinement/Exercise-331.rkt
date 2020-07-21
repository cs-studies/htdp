;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-331) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 331.
;; Design the function how-many,
;; which determines how many files a given Dir contains.


;; A File is a String.

;; A Dir (short for directory) is one of:
;; – '()
;; – (cons File Dir)
;; – (cons Dir Dir)


(define Dir-Text (cons "part1" (cons "part2" (cons "part3" '()))))

(define Dir-Code (cons "hang" (cons "draw" '())))

(define Dir-Docs (cons "read!" '()))

(define Dir-Libs (cons Dir-Code (cons Dir-Docs '())))

(define Dir-TS (cons "read!" (cons Dir-Text (cons Dir-Libs '()))))


;; Dir -> Number
;; Determines how many files a given Dir contains.
(check-expect (how-many '()) 0)
(check-expect (how-many Dir-Docs) 1)
(check-expect (how-many Dir-TS) 7)
(define (how-many d)
  (cond
    [(empty? d) 0]
    [else (+ (if (string? (first d))
                 1
                 (how-many (first d)))
             (how-many (rest d)))]))

