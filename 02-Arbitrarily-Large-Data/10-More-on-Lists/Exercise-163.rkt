;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-163) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 163.
;; Design convertFC.
;; The function converts a list of measurements in Fahrenheit to a list of Celsius measurements.


;; A List-of-numbers is one of:
;; - '()
;; - (cons Number List-of-numbers)

;; List-of-numbers -> List-of-numbers
;; Converts a list of measurements in Fahrenheit
;; to a list of Celsius measurements.
(check-expect (convertFC '()) '())
(check-within (convertFC (cons 0 (cons 32 (cons 212 '()))))
                         (cons -17.78 (cons 0 (cons 100 '()))) 0.01)
#|
;; Template
(define (convertFC fl)
  (cond
    [(empty? fl) ...]
    [else (... (first fl) ... (convertFC (rest fl)) ...)]))
|#
(define (convertFC fl)
  (cond
    [(empty? fl) '()]
    [else (cons (* 5/9 (- (first fl) 32)) (convertFC (rest fl)))]))

