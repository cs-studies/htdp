;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-37) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 37.
;; Design the function string-rest,
;; which produces a string like the given one
;; with the first character removed.

;; 1. Express how you wish to represent information as data.

; We use String data type to represent textual information.


;; 2. Write down:
;;   - a signature
;;   - a statement of purpose
;;   - a function header

; String -> String
; Removes first character from a string.
; (define (f str) "abc")


;; 3. Illustrate the signature and the purpose statement
;; with some functional examples.

; "Fun Fact" -> "un Fact"
; "0-day" -> "-day"


;; 4. Write down function prototype: header and body template.

; (define (string-rest str) (... str ...))


;; 5. Write down the function.

(define (string-rest str)
  (substring str 1))


;; 6. Test the function on the step 3 examples.

(string-rest "Fun Fact")

(string-rest "0-day")

