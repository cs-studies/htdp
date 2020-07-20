;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-135) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 135.
;; Use DrRacket’s stepper to check the calculation for
;; (contains-flatt? (cons "Flatt" (cons "C" '())))
;; Also use the stepper to determine the value of
;; (contains-flatt?
;;  (cons "A" (cons "Flatt" (cons "C" '()))))


;; A List-of-names is one of:
;; – '()
;; – (cons String List-of-names)
;; Represents a contact list for a cell phone.

;; List-of-names -> Boolean
;; Determines whether "Flatt" is on a-list-of-names.
(define (contains-flatt? names)
  (cond
    [(empty? names) #false]
    [(cons? names)
     (or (string=? (first names) "Flatt")
         (contains-flatt? (rest names)))]))


(contains-flatt? (cons "Flatt" (cons "C" '())))


(contains-flatt?
 (cons "A" (cons "Flatt" (cons "C" '()))))


;;; Question
;; What happens when "Flatt" is replaced with "B"?
(contains-flatt?
 (cons "A" (cons "B" (cons "C" '()))))

;;; Answer
;; contains-flatt? checks each cons - one by one - and
;; returns #false as the result.

