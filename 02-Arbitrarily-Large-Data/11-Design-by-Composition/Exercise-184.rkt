;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-184) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 184.
;; Determine the values of the following expressions.
;; Use check-expect to express your answers.


(define list-1
  (list (string=? "a" "b") #false))

(check-expect list-1 (list #false #false))


(define list-2
  (list (+ 10 20) (* 10 20) (/ 10 20)))

(check-expect list-2 (list 30 200 10/20))


(define list-3
  (list "dana" "jane" "mary" "laura"))

(check-expect list-3 (list "dana" "jane" "mary" "laura"))

