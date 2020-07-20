;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-133) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 133.
;; Explain why this expression produces the same answers
;; as the or expression in the version of figure 47.
;; Which version is clearer to you? Explain.


;; A List-of-names is one of:
;; – '()
;; – (cons String List-of-names)
;; Represents a contact list for a cell phone.

;; List-of-names -> Boolean
;; Determines whether "Flatt" is on a-list-of-names.
(check-expect (contains-flatt? '()) #false)
(check-expect (contains-flatt? (cons "Find" '())) #false)
(check-expect (contains-flatt? (cons "Flatt" '())) #true)
(check-expect (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '())))) #true)
(check-expect (contains-flatt? (cons "A" (cons "B" (cons "C" '())))) #false)
(define (contains-flatt? names)
  (cond
    [(empty? names) #false]
    [(cons? names)
     (or (string=? (first names) "Flatt")
         (contains-flatt? (rest names)))]))

;; List-of-names -> Boolean
;; Determines whether "Flatt" is on a-list-of-names
;; using "cond" formulating the second cond clause.
(check-expect (contains-flatt-cond? '()) #false)
(check-expect (contains-flatt-cond? (cons "Find" '())) #false)
(check-expect (contains-flatt-cond? (cons "Flatt" '())) #true)
(check-expect (contains-flatt-cond? (cons "A" (cons "Flatt" (cons "C" '())))) #true)
(check-expect (contains-flatt-cond? (cons "A" (cons "B" (cons "C" '())))) #false)
(define (contains-flatt-cond? names)
  (cond
    [(empty? names) #false]
    [(cons? names)
     (cond
       [(string=? (first names) "Flatt") #true]
       [else (contains-flatt-cond? (rest names))])]))

;; List-of-names -> Boolean
;; Determines whether "Flatt" is on a-list-of-names
;; using "if" formulating the second cond clause.
(check-expect (contains-flatt-if? '()) #false)
(check-expect (contains-flatt-if? (cons "Find" '())) #false)
(check-expect (contains-flatt-if? (cons "Flatt" '())) #true)
(check-expect (contains-flatt-if? (cons "A" (cons "Flatt" (cons "C" '())))) #true)
(check-expect (contains-flatt-if? (cons "A" (cons "B" (cons "C" '())))) #false)
(define (contains-flatt-if? names)
  (cond
    [(empty? names) #false]
    [(cons? names)
     (if (string=? (first names) "Flatt")
         #true
         (contains-flatt-if? (rest names)))]))


;;; Answer
;; The results are the same because these expressions
;; are identical in the resulting evaluation flow.
;; At the moment of writing, "contains-flatt-if" way is the clearest to me.
;; It seems to be more of a matter of personal taste and perception.

