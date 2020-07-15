;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-307) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 307.
;; Define find-name.
;; The function consumes a name and a list of names.
;; It retrieves the first name on the latter
;; that is equal to, or an extension of, the former.
;;
;; Define a function that ensures
;; that no name on some list of names exceeds some given width.
;; Compare with exercise 271.
;; (See also exercise 289.)


(require 2htdp/abstraction)


;; String [List-of String] -> [Maybe String]
;; Retrieves the first found string on the list los
;; that is equal to or an extension of the given name.
(check-expect (find-name "cat" '()) #false)
(check-expect (find-name "cat" '("dog" "fish")) #false)
(check-expect (find-name "cat" '("dog" "cat" "fish" "caterpillar")) "cat")
(check-expect (find-name "cat" '("dog" "caterpillar" "fish")) "caterpillar")
(define (find-name name los)
  (for/or ([s los]) (if (starts-with? s name) s #false)))

;; String String -> Boolean
;; Determines whether the str1 starts with the str2.
(check-expect (starts-with? "cat" "dog") #false)
(check-expect (starts-with? "cat" "c") #true)
(define (starts-with? str1 str2)
  (or (string=? str1 str2)
      (and (> (string-length str1) (string-length str2))
           (string=? (substring str1 0 (string-length str2)) str2))))

;; Number [List-of String] -> Boolean
;; Ensures no name on the given list exceeds the length n.
(check-expect (in-limit? 3 '()) #true)
(check-expect (in-limit? 3 '("cat" "dog")) #true)
(check-expect (in-limit? 3 '("cat" "dog" "fish")) #false)
(define (in-limit? n los)
  (for/and ([s los]) (>= n (string-length s))))

