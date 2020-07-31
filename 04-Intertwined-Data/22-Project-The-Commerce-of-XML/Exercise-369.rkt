;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-369) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 369.
;; Design find-attr.
;; The function consumes a list of attributes and a symbol.
;; If the attributes list associates the symbol with a string,
;; the function retrieves this string;
;; otherwise it returns #false.


;; An Xexpr is a list:
;; – (cons Symbol Body)
;; – (cons Symbol (cons [List-of Attribute] Body))
;; where Body is short for [List-of Xexpr]
;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))


(define a0 '((initial "X")))
(define a1 '((name "observer")))
(define a2 '((status "free")))

(define loa (append a0 a1 a2))


;; [List-of Attribute] Symbol -> [Maybe String]
;; Retrieves a string associated with s from loa.
(check-expect (find-attr '() 'x) #false)
(check-expect (find-attr loa 'x) #false)
(check-expect (find-attr loa 'name) "observer")
(define (find-attr loa s)
  (local ((define found (assq s loa)))
    (if (false? found)
        #false
        (second found))))

