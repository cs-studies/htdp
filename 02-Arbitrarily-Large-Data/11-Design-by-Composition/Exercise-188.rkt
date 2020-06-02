;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-188) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 188.
;; Design a program that sorts lists of emails by date.
;; Also develop a program that sorts lists of email messages by name.
;; To compare two strings alphabetically, use the string<? primitive.

;;; Data Definitions

(define-struct email [from date message])
;; An Email is a structure:
;;   (make-email String Number String)
;; (make-email f d m) represents text m
;; sent by f, d seconds after the beginning of time.


;; A List-of-emails is one of:
;; - '()
;; - (cons Email List-of-emails)


;;; Test Data
(define E1 (make-email "B.Y." 2 "Hi"))
(define E2 (make-email "C.Z." 15 "Thanks"))
(define E3 (make-email "A.X." 28 "Bye"))


;; List-of-emails -> List-of-emails
;; Produces a sorted by date version of the given list of emails.
(check-expect (sort-by-date> '()) '())
(check-expect (sort-by-date> (list E1)) (list E1))
(check-expect (sort-by-date> (list E2 E1)) (list E2 E1))
(check-expect (sort-by-date> (list E1 E2)) (list E2 E1))
(check-expect (sort-by-date> (list E1 E2 E3)) (list E3 E2 E1))
(check-expect (sort-by-date> (list E2 E1 E3)) (list E3 E2 E1))
(check-expect (sort-by-date> (list E3 E2 E1)) (list E3 E2 E1))
(define (sort-by-date> l)
  (cond
    [(empty? l) '()]
    [else (insert-by-date (first l) (sort-by-date> (rest l)))]))

;; Email List-of-emails -> List-of-emails
;; Inserts an Email into the sorted by date list of emails.
(check-expect (insert-by-date E1 '()) (list E1))
(check-expect (insert-by-date E1 (list E2)) (list E2 E1))
(check-expect (insert-by-date E2 (list E1)) (list E2 E1))
(check-expect (insert-by-date E2 (list E3 E1)) (list E3 E2 E1))
(check-expect (insert-by-date E1 (list E3 E2)) (list E3 E2 E1))
(check-expect (insert-by-date E3 (list E2 E1)) (list E3 E2 E1))
(define (insert-by-date e l)
  (cond
    [(empty? l) (cons e l)]
    [else (if (>= (email-date e) (email-date (first l)))
              (cons e l)
              (cons (first l) (insert-by-date e (rest l))))]))

#|
(define E1 (make-email "B.Y." 2 "Hi"))
(define E2 (make-email "C.Z." 15 "Thanks"))
(define E3 (make-email "A.X." 28 "Bye"))
|#

;; List-of-emails -> List-of-emails
;; Produces a sorted by name version of the given list of emails.
(check-expect (sort-by-name> '()) '())
(check-expect (sort-by-name> (list E1)) (list E1))
(check-expect (sort-by-name> (list E2 E1)) (list E2 E1))
(check-expect (sort-by-name> (list E1 E2)) (list E2 E1))
(check-expect (sort-by-name> (list E1 E2 E3)) (list E2 E1 E3))
(check-expect (sort-by-name> (list E2 E3 E1)) (list E2 E1 E3))
(check-expect (sort-by-name> (list E3 E2 E1)) (list E2 E1 E3))
(define (sort-by-name> l)
  (cond
    [(empty? l) '()]
    [else (insert-by-name (first l) (sort-by-name> (rest l)))]))

;; Email List-of-emails -> List-of-emails
;; Inserts an Email into the sorted by name list of emails.
(check-expect (insert-by-name E1 '()) (list E1))
(check-expect (insert-by-name E1 (list E2)) (list E2 E1))
(check-expect (insert-by-name E2 (list E1)) (list E2 E1))
(check-expect (insert-by-name E2 (list E1 E3)) (list E2 E1 E3))
(check-expect (insert-by-name E1 (list E2 E3)) (list E2 E1 E3))
(check-expect (insert-by-name E3 (list E2 E1)) (list E2 E1 E3))
(define (insert-by-name e l)
  (cond
    [(empty? l) (cons e l)]
    [else (if (string<? (email-from (first l)) (email-from e))
              (cons e l)
              (cons (first l) (insert-by-name e (rest l))))]))


;;; Application

;(sort-by-date> (list E2 E3 E1))

;(sort-by-name> (list E2 E3 E1))

