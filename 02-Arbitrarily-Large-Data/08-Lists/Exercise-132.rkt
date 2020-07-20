;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-132) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 132.
;; Use DrRacket to run contains-flatt? in this example:

(define contact-list
  (cons "Fagan"
        (cons "Findler"
              (cons "Fisler"
                    (cons "Flanagan"
                          (cons "Flatt"
                                (cons "Felleisen"
                                      (cons "Friedman" '()))))))))

;;; Question
;; What answer do you expect?

;;; Answer
;; #true


;; A List-of-names is one of:
;; – '()
;; – (cons String List-of-names)
;; Represents a contact list for a cell phone.

;; List-of-names -> Boolean
;; Determines whether "Flatt" is on a-list-of-names.
(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Find" '()))
              #false)
(check-expect (contains-flatt? (cons "Flatt" '()))
              #true)
(check-expect (contains-flatt?
               (cons "A" (cons "Flatt" (cons "C" '()))))
              #true)
(check-expect (contains-flatt?
               (cons "A" (cons "B" (cons "C" '()))))
              #false)
(define (contains-flatt? names)
  (cond
    [(empty? names) #false]
    [(cons? names)
     (or (string=? (first names) "Flatt")
         (contains-flatt? (rest names)))]))


;;; Application
(contains-flatt? contact-list)

