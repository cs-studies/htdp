;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-208) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 208.
;; Design boolean-attributes.
;; The function consumes an LLists
;; and produces the Strings that are associated with a Boolean attribute.


(require 2htdp/itunes)


;; LLists -> List-of-strings
;; Procudes the list of unique strings
;; that are associated with Boolean attributes.
(check-expect (boolean-attributes '()) '())
(check-expect (boolean-attributes (list (list "Name" "a"))) '())
(check-expect (boolean-attributes (list (list "Name" "a") (list "Bool" #true)))
              (list "Bool"))
(check-expect (boolean-attributes
               (list (list "Name" "a") (list "Bool" #true) (list "Yes" #false)))
              (list "Bool" "Yes"))
(check-expect (boolean-attributes
               (list (list "Name" "a") (list "Bool" #true) (list "Yes" #false) (list "Bool" #false)))
              (list "Yes" "Bool"))
(define (boolean-attributes l)
  (create-set (boolean-attributes-all l)))

;; LLists -> List-of-strings
;; Produces the list of strings
;; that are associated with Boolean attributes.
(check-expect (boolean-attributes-all
               (list (list "Name" "a") (list "Bool" #true) (list "Yes" #false) (list "Bool" #false)))
              (list "Bool" "Yes" "Bool"))
(define (boolean-attributes-all l)
  (cond
    [(empty? l) '()]
    [else (if (boolean? (second (first l)))
              (cons (first (first l)) (boolean-attributes-all (rest l)))
              (boolean-attributes-all (rest l)))]))

;; List-of-strings -> List-of-strings
;; Produces a list of unique strings.
(check-expect (create-set '()) '())
(check-expect (create-set (list "a")) (list "a"))
(check-expect (create-set (list "a" "a")) (list "a"))
(check-expect (create-set (list "a" "a" "b")) (list "a" "b"))
(check-expect (create-set (list "b" "a" "b" "a")) (list "b" "a"))
(define (create-set l)
  (cond
    [(empty? l) '()]
    [else (if (member? (first l) (rest l))
              (create-set (rest l))
              (cons (first l) (create-set (rest l))))]))

