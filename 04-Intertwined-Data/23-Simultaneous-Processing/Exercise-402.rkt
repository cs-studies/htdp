;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-402) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 402.
;; Reread exercise 354.
;; Explain the reasoning behind our hint
;; to think of the given expression as an atomic value at first.


;;; Answer.
;; Given two complex inputs, only one of which is a list,
;; it's often more convenient to consider another input as an atomic value
;; and traverse the list,
;; performing all required manipulations with the data available at each step.
;; This approach was described as a "situation 1" in the chapter
;; "23.5 Designing Functions that Consume Two Complex Inputs".
;; It was applicable for the exercise 354 case.

