;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-34) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 34.
;; Design the function string-first,
;; which extracts the first character from a non-empty string.
;; Don’t worry about empty strings.

;; 1. Express how you wish to represent information as data.

; We use String data type to represent textual information.


;; 2. Write down:
;;   - a signature
;;   - a statement of purpose
;;   - a function header

; String -> 1String
; Extracts the first character from a string.
; (define (f str) "a")


;; 3. Illustrate the signature and the purpose statement
;; with some functional examples.

; "z" -> "z"
; "0-day" -> "0"
; "Fun Fact" -> "F"


;; 4. Write down function prototype: header and body template.

; (define (string-first s) (... s ...))


;; 5. Write down the function.

(define (string-first s)
  (substring s 0 1))


;; 6. Test the function on the step 3 examples.

(string-first "z")

(string-first "0-day")

(string-first "Fun Fact")

