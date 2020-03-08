;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-35) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 35.
;; Design the function string-last,
;; which extracts the last character from a non-empty string.

;; 1. Express how you wish to represent information as data.

; We use String data type to represent textual information.


;; 2. Write down:
;;   - a signature
;;   - a statement of purpose
;;   - a function header

; String -> 1String
; Extracts the last character from a string.
; (define (f str) "z")


;; 3. Illustrate the signature and the purpose statement
;; with some functional examples.

; "z" -> "z"
; "0-day-1" -> "1"
; "Fun FacT" -> "T"


;; 4. Write down function prototype: header and body template.

; (define (string-last s) (... s ...))


;; 5. Write down the function.

(define (string-last s)
  (substring s (- (string-length s) 1)))


;; 6. Test the function on the step 3 examples.

(string-last "z")

(string-last "0-day-1")

(string-last "Fun FacT")

