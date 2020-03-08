;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-38) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 38.
;; Design the function string-remove-last,
;; which produces a string like the given one
;; with the last character removed.

;; 1. Express how you wish to represent information as data.

; We use String data type to represent textual information.


;; 2. Write down:
;;   - a signature
;;   - a statement of purpose
;;   - a function header

; String -> String
; Removes last character from a string.
; (define (f str) "abc")


;; 3. Illustrate the signature and the purpose statement
;; with some functional examples.

; "0-day" -> "0-da"
; "FYI" -> "FY"

;; 4. Write down function prototype: header and body template.

; (define (string-remove-last str) (... str ...))


;; 5. Write down the function.

(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))


;; 6. Test the function on the step 3 examples.

(string-remove-last "0-day")

(string-remove-last "FYI")

