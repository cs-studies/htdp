;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-130) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 130.
;; Create an element of List-of-names that contains five Strings.


;; A List-of-names is one of:
;; – '()
;; – (cons String List-of-names)
;; Represents a list of invitees, by last name.


(cons "Liszt"
      (cons "Mozart"
            (cons "Bach"
                  (cons "Prokofiev"
                        (cons "Glass"
                              '())))))

;;; Question
;; Explain why
;; (cons "1" (cons "2" '()))
;; is an element of List-of-names and why (cons 2 '()) isn’t.

;;; Answer
;; Because "2" is a String, which is a valid first field data type.
;; 2 is a Number, not a String. So 2 is not a valid first field data type.

