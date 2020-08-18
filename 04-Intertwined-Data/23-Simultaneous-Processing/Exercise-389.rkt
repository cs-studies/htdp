;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-389) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 389.
;; Design the zip function,
;; which consumes a list of names, represented as strings,
;; and a list of phone numbers, also strings.
;; It combines those equally long lists into a list of phone records.
;; Assume that the corresponding list items belong to the same person.


(define-struct phone-record [name number])
;; A PhoneRecord is a structure:
;;    (make-phone-record String String)


;; [List-of String] [List-of String] -> [List-of PhoneRecord]
;; Combines a list of names and a list of phone numbers
;; into one list of phone records.
(check-expect (zip '() '()) '())
(check-expect (zip '("Nadine") '("222-333"))
              (list (make-phone-record "Nadine" "222-333")))
(check-expect (zip '("Nadine" "Max") '("222-333" "111-555"))
              (list (make-phone-record "Nadine" "222-333")
                    (make-phone-record "Max" "111-555")))
(define (zip lon lop)
  (cond
    [(empty? lon) '()]
    [else (cons (make-phone-record (first lon) (first lop))
                (zip (rest lon) (rest lop)))]))

