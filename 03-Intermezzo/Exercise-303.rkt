;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-303) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 303.


(lambda (x y) ; binding occurence
  ;----------------
  (+ x
     (* x y))
  ;----------------
  )


(lambda (x y) ; binding occurence
  ;-----------------------------------------
  (+ x
     ;;------------------------- and the hole in the outer scope
     (local ((define x (* y y))) ; binding occurence
       (+ (* 3 x)
          (/ 1 x))
       )
     ;;--------------------------
     )
  ;-----------------------------------------
  )


(lambda (x y) ; binding occurence
  ;------------------------
  (+ x
     (
      ;;----------------- the hole in the outer scope
      (lambda (x) ; binding occurrence
        ;;;----------
        (+ (* 3 x)
           (/ 1 x))
        ;;;----------
        )
      ;;-----------------
      (* y y)))
  ;------------------------
  )

