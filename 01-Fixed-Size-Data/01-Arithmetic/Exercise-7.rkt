;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
#|
Add these two lines to the definitions area of DrRacket:
(define sunny #true)
(define friday #false)
Now create an expression that computes whether sunny is false or friday is true.
So in this particular case, the answer is #false. (Why?)
|#

(require 2htdp/image)

; Definitions
(define sunny #true)
(define friday #false)

; Application
(or (not sunny) friday)