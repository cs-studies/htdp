;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-154) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 154.
;; Design the function colors.
;; It consumes a Russian doll and produces a string of all colors,
;; separated by a comma and a space.


(define-struct layer [color doll])

;; A Doll is one of:
;; – String
;; – (make-layer String Doll)


;; Doll -> String
;; Produces a string of all colors of the d.
(check-expect (colors "red") "red")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) "yellow, green, red")
#|
;; Template
(define (colors d)
  (cond
    [(string? d) ...]
    [(layer? d) (... (layer-color d) ... (colors (layer-doll d) ...))]))
|#
(define (colors d)
  (cond
    [(string? d) d]
    [(layer? d) (string-append (layer-color d) ", " (colors (layer-doll d)))]))

