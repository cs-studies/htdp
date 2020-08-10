;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-385) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 385.
;; Use read-xexpr in DrRacket to view the source code
;; of the page with the current stock price as an Xexpr.


(require 2htdp/batch-io)


;; An Attribute is a list of two items:
;;    (list Symbol String)

;; An Attribute* is a [List-of Attribute]

;; An Xexpr is one of:
;; - Symbol
;; - String
;; - Number
;; - (cons Symbol (cons Attribute* [List-of Xexpr]))
;; - (cons Symbol [List-of Xexpr])


(read-xexpr "./files/Ford.html")

