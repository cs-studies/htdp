;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-178) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 178.
;; Explain why the template for editor-kh deals with "\t" and "\r"
;; before it checks for strings of length 1.


;;; Answer
;; Because the length of "\t" and "\b" equals to 1.
;; But at the same time, these keys presses have to be handled differently
;; from other keys presses that also identified by the strings of length 1.
;; https://docs.racket-lang.org/teachpack/2htdpuniverse.html?q=universe#%28tech._world._keyevent%29

(string-length "\t")

(string-length "\b")

