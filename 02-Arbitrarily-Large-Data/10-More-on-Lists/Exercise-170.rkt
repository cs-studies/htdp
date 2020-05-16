;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-170) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 170.
;; Design the function replace.
;; It consumes and produces a list of Phones.
;; It replaces all occurrence of area code 713 with 281.


(define-struct phone [area switch four])
;; A Phone is a structure:
;;   (make-phone Three Three Four)
;; A Three is a Number between 100 and 999.
;; A Four is a Number between 1000 and 9999.


;; A List-of-phones is one of:
;; - '()
;; - (cons Phone List-of-phones)


;; List-of-phones -> List-of-phones
;; Replaces all occurrences of area code 713 with 281.
(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 555 111 5555) (cons (make-phone 713 222 7777) '())))
              (cons (make-phone 555 111 5555) (cons (make-phone 281 222 7777) '())))
#|
;; Template
(define (replace lp)
  (cond
    [(empty? lp) ...]
    [(cons? lp) (... (first lp) ...
                     ... ... (phone-area (first lp)) ...
                     ... ... (phone-switch (first lp)) ...
                     ... ... (phone-four (first lp)) ...
                     (replace (rest lp)) ...)]))
|#
(define (replace lp)
  (cond
    [(empty? lp) '()]
    [(cons? lp) (cons (make-phone
                       (if (= (phone-area (first lp)) 713)
                           281
                           (phone-area (first lp)))
                       (phone-switch (first lp))
                       (phone-four (first lp)))
                      (replace (rest lp)))]))

