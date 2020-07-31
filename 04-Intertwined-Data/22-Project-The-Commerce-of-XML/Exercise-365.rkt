;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-365) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 365.
;; Interpret the following elements of Xexpr.v2 as XML data.
;; Which ones are elements of Xexpr.v0 or Xexpr.v1?


;; An Xexpr.v0 (short for X-expression) is a one-item list:
;;   (cons Symbol '())

;; An Xexpr.v1 is a list:
;;   (cons Symbol [List-of Xexpr.v1])

;; An Xexpr.v2 is a list:
;; – (cons Symbol Body)
;; – (cons Symbol (cons [List-of Attribute] Body))
;; where Body is short for [List-of Xexpr.v2]
;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))


'(server ((name "example.org")))
;; <server name="example.org" />

'(carcas (board (grass)) (player ((name "sam"))))
;; <carcas>
;;    <board><grass /></board>
;;    <player name="sam" />
;; </carcas>

'(start)
;; <start />


;;; Answer.
;; 'start is an element of Xexpr.v0 and Xexpr.v1.

