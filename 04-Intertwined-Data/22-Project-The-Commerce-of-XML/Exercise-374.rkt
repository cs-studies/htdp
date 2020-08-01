;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-374) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 374.
;; The data definitions in figure 127 use list.
;; Rewrite them so they use cons.
;; Then use the recipe to design
;; the rendering functions for XEnum and XItem from scratch.
;; You should come up with the same definitions as in figure 128.


;;; Data Definitions

;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))

;; An XWord is '(word ((text String))).

;; An XItem is one of:
;; – (cons 'li (cons XWord '()))
;; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
;; – (cons 'li (cons XEnum '()))
;; – (cons 'li (cons [List-of Attribute] (cons XEnum '())))

;; An XEnum is one of:
;; – (cons 'ul [List-of XItem])
;; – (cons 'ul (cons [List-of Attribute] [List-of XItem]))

