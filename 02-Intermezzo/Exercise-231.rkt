;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-231) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 231.
;; Eliminate quote in favor of list from the following expressions.


'(1 "a" 2 #false 3 "c")
; ==
(list '1 '"a" '2 '#false '3 '"c")
; ==
(list 1 "a" 2 #false 3 "c")


'()
; ==
empty


'(("alan" 1000)
  ("barb" 2000)
  ("carl" 1500))
; ==
(list '("alan" 1000) '("barb" 2000) '("carl" 1500))
; ==
(list (list '"alan" '1000) (list '"barb" '2000) (list '"carl" '1500))
; ==
(list (list "alan" 1000) (list "barb" 2000) (list "carl" 1500))

