;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-370) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 370.
;; Make up three examples for XWords.
;; Design word?,
;; which checks whether some ISL+ value is in XWord;
;; and word-text,
;; which extracts the value of the only attribute of an instance of XWord.


(require 2htdp/abstraction)


;; An XWord is '(word ((text String))).


(define w1
'(word ((text "Mamma Mia"))))

(define w2
'(word ((text "Cabaret"))))

(define w3
  '(word ((text "Black Ops"))))


;; Any -> Boolean
;; Determines whether v is an XWord.
(check-expect (word? '()) #false)
(check-expect (word? '(word ((text 20)))) #false)
(check-expect (word? 10) #false)
(check-expect (word? "word") #false)
(check-expect (word? w1) #true)
(check-expect (word? w2) #true)
(check-expect (word? w3) #true)
(define (word? v)
  (match v
    [(list 'word (list (list 'text (? string?)))) #true]
    [else #false]))

;; XWord -> String
;; Retrieves the value of the only attributes of w.
(check-expect (word-text w1) "Mamma Mia")
(check-expect (word-text w2) "Cabaret")
(check-expect (word-text w3) "Black Ops")
(define (word-text w)
  (match w
    [(list 'word (list (list 'text txt))) txt]))

