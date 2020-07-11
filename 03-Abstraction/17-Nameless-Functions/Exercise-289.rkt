;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-289) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 289.
;; Use ormap to define find-name.
;; The function consumes a name and a list of names.
;; It determines whether any of the names on the latter are equal to or an extension of the former.
;;
;; With andmap you can define a function
;; that checks all names on a list of names that start with the letter "a".


;; String [List-of String] -> Boolean
;; Determines whether any of the strings on the list l
;; are equal to or an extension of the name.
(check-expect (find-name "cat" '()) #false)
(check-expect (find-name "cat" '("dog" "fish")) #false)
(check-expect (find-name "cat" '("dog" "cat" "fish")) #true)
(check-expect (find-name "cat" '("dog" "caterpillar" "fish")) #true)
(define (find-name name los)
  (ormap (lambda (str) (starts-with? str name)) los))

;; 1String [List-of String] -> Boolean
;; Determines whether all of the strings on the list l
;; start with the given letter.
(check-expect (all-start-with? "a" '()) #true)
(check-expect (all-start-with? "a" '("abra" "cadabra")) #false)
(check-expect (all-start-with? "a" '("abrac" "adabra")) #true)
(define (all-start-with? char los)
    (andmap (lambda (str) (starts-with? str char)) los))

;; String String -> Boolean
;; Determines whether the str1 starts with the str2.
(check-expect (starts-with? "cat" "dog") #false)
(check-expect (starts-with? "cat" "c") #true)
(define (starts-with? str1 str2)
  (or (string=? str1 str2)
      (and (> (string-length str1) (string-length str2))
           (string=? (substring str1 0 (string-length str2)) str2))))

