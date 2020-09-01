;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-423) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 423.
;; Define partition.
;; It consumes a String s and a natural number n.
;; The function produces a list of string chunks of size n.


;; N is one of:
;; - 0
;; - (add1 N)


;; String N ->[List-of String]
;; Produces a list of string chunks of size n.
(check-expect (partition "" 0) '())
(check-expect (partition "" 1) '())
(check-expect (partition "a" 1) '(("a")))
(check-expect (partition "a" 2) '(("a")))
(check-expect (partition "ab" 1) '(("a") ("b")))
(check-expect (partition "ab" 2) '(("ab")))
(check-expect (partition "abc" 2) '(("ab") ("c")))
(check-expect (partition "abcdefgh" 3) '(("abc") ("def") ("gh")))
(define (partition s n)
  (local ((define str-length (string-length s)))
    (cond
      [(or (zero? str-length) (zero? n)) '()]
      [else (if (>= n str-length)
                (cons (list s) '())
                (cons (list (substring s 0 n))
                      (partition (substring s n str-length) n)))])))

