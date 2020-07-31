;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-367) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 367.
;; The design recipe calls for a self-reference
;; in the template for xexpr-attr.
;; Add this self-reference to the template
;; and then explain why the finished parsing function does not contain it.


;; An Xexpr is a list:
;; – (cons Symbol Body)
;; – (cons Symbol (cons [List-of Attribute] Body))
;; where Body is short for [List-of Xexpr]
;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))


(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) ...]
      [else (... (first optional-loa+content) ...
             ... (xexpr-attr (rest optional-loa+content)) ...)])))


;;; Answer.
;; According to the Xexpr data definition,
;; a list of attributes can (optionally) be located
;; only at the second position of a Xexpr list.
;; It is enough to check an element at the second position
;; - if present - of a Xexpr list only once
;; to determine whether it is a list of attributes.

