;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-255) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 255.
;; Formulate signatures for the following functions:
;; - map-n
;; - map-s
;; Then abstract over the two signatures.
;; Also show that the generalized signature can be instantiated
;; to describe the signature of the map1 function above.


;; map-n signature
;; [List-of Number] [Number -> Number] -> [List-of Number]

;; map-s signature
;; [List-of String] [String -> String] -> [List-of String]

;; abstract signature
;; [List-of X] [X -> X] -> [List-of X]

;; map1 signature
;; [List-of X] [X -> Y] -> [List-of Y]
;; also covers
;; [List-of IR] [IR -> String] -> [List-of String]

