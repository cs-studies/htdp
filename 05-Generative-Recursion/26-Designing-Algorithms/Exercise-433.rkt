;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-433) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 433.
;; Develop a checked version of bundle
;; that is guaranteed to terminate for all inputs.
;; It may signal an error for those cases where the original version loops.


;; N is one of:
;; - 1
;; - (add1 N)


(define ERR "n must be larger than 0")

;; [List-of 1String] N -> [List-of String]
;; Bundles chunks of s into strings of length n.
(check-expect (bundle '() 2) '())
(check-error (bundle '("a" "b" "c") 0) ERR)
(check-expect (bundle '("a" "b") 1) '("a" "b"))
(check-expect (bundle '("a" "b") 2) '("ab"))
(check-expect (bundle '("a" "b") 3) '("ab"))
(check-expect (bundle (explode "abcdefg") 3) '("abc" "def" "g"))
(define (bundle s n)
  (cond
    [(empty? s) '()]
    [(zero? n) (error ERR)]
    [else
     (local ((define (take l n)
               (cond
                 [(or (zero? n) (empty? l)) '()]
                 [else (cons (first l) (take (rest l) (sub1 n)))]))

             (define (drop l n)
               (cond
                 [(or (zero? n) (empty? l)) l]
                 [else (drop (rest l) (sub1 n))])))
       (cons (implode (take s n)) (bundle (drop s n) n)))]))

