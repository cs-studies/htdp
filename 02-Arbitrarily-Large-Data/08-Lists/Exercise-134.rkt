;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-134) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 134.
;; Develop the contains? function,
;; which determines whether some given string occurs on a given list of strings.


;; A List-of-strings is one of:
;; – '()
;; – (cons String List-of-strings)


;; List-of-strings -> Boolean
;; Determines whether str is on strings-list.
(check-expect (contains? '() "a") #false)
(check-expect (contains? (cons "a" '()) "a") #true)
(check-expect (contains? (cons "b" '()) "a") #false)
(check-expect (contains? (cons "a" (cons "b" '())) "a") #true)
(check-expect (contains? (cons "b" (cons "a" '())) "a") #true)
(check-expect (contains? (cons "b" (cons "c" '())) "a") #false)
(define (contains? string-list str)
  (cond
    [(empty? string-list) #false]
    [else
     (if (string=? str (first string-list))
         #true
         (contains? (rest string-list) str))]))

