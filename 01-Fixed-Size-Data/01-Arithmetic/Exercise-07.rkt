;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-7) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 7.
;; Add these two lines to the definitions area of DrRacket:
;; (define sunny #true)
;; (define friday #false)
;; Now create an expression that computes whether sunny is false or friday is true.
;; So in this particular case, the answer is #false. (Why?)
;; How many combinations of Booleans can you associate with sunny and friday?

(require 2htdp/image)

;; Definitions
(define sunny #true)
(define friday #false)

;; Application
(or (not sunny) friday) ; outputs #false, because both (not sunny) and friday evaluate to #false.

;; Answer
;; Four combinations of Booleans can be associated with sunny and friday:
;; ------------------
;; # | sunny | friday
;; ------------------
;; 1 | true  | true
;; 2 | true  | false
;; 3 | false | true
;; 4 | false | false
;; ------------------

