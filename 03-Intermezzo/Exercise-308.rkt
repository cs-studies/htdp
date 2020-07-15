;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-308) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 308.
;; Design the function replace,
;; which substitutes the area code 713 with 281 in a list of phone records.


(require 2htdp/abstraction)


(define-struct phone [area switch four])

(define phone1 (make-phone 713 111 1111))
(define phone2 (make-phone 555 222 2222))
(define phone3 (make-phone 713 333 3333))

;; [List-of Phone] -> [List-of Phone]
;; Substitutes the area code 713 with 281.
(check-expect (replace (list phone1 phone2 phone3))
              (list (make-phone 281 111 1111)
                    (make-phone 555 222 2222)
                    (make-phone 281 333 3333)))
(define (replace l)
  (for/list ([p l])
    (match p
      [(phone a s f)
       (make-phone (if (= a 713) 281 a) s f)])))

