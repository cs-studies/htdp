;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-330) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 330.
;; Translate the directory tree in figure 123
;; into a data representation according to model 1.


;; A File is a String.

;; A Dir (short for directory) is one of:
;; – '()
;; – (cons File Dir)
;; – (cons Dir Dir)


(define Dir-Text (cons "part1" (cons "part2" (cons "part3" '()))))


(define Dir-Code (cons "hang" (cons "draw" '())))

(define Dir-Docs (cons "read!" '()))

(define Dir-Libs (cons Dir-Code (cons Dir-Docs '())))


(define Dir-TS (cons Dir-Text (cons "read!" (cons Dir-Libs '()))))

(check-expect Dir-TS '(("part1" "part2" "part3")
                       "read!"
                       (("hang" "draw")
                        ("read!"))))

