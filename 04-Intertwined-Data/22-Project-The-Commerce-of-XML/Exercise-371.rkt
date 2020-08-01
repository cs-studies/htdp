;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-371) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 371.
;; Refine the definition of Xexpr
;; so that you can represent XML elements,
;; including items in enumerations, that are plain strings.


;; An XWord is '(word ((text String))).

;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))

;; A Body is one of:
;; - [List-of Xexpr]
;; - XWord

;; An Xexpr is a list:
;; – (cons Symbol Body)
;; – (cons Symbol (cons [List-of Attribute] Body))


;; <ul>
;;    <li>Hey hey</li>
;;    <li>Hiya</li>
;; </ul>

