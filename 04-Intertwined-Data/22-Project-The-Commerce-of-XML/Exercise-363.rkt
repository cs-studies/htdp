;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-363) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 363.
;; Reformulate the definition of Xexpr
;; to isolate the common beginning
;; and highlight the different kinds of endings.
;; Eliminate the use of List-of.


;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))

;; A Body is one of:
;; - '()
;; - (cons Xexpr Body)
;; - (cons [List-of Attribute] Body)

;; An Xexpr is a list (cons Symbol Body)

