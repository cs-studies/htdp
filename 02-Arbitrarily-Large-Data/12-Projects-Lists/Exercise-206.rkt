;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-206) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 206.
;; Design the function find-association.
;; It consumes three arguments:
;; a String called key, an LAssoc, and an element of Any called default.
;; It produces the first Association whose first item is equal to key,
;; or default if there is no such Association.


(require 2htdp/itunes)


;; year month day hour minute second
(define DATE1 (create-date 2020 2 20 12 0 0))
(define DATE2 (create-date 2020 5 15 23 15 30))

(define LASSOC1
  (list
   (list "Track ID" 1)
   (list "Name" "Joyful Sonata")
   (list "Artist" "T. Nikolayeva")
   (list "Album" "The Best of Piano")
   (list "Total Time" 301641)
   (list "Track Number" 44)
   (list "Date Added" DATE1)
   (list "Play Count" 77)
   (list "Date Modified" DATE2)))

;; String LAssoc Any -> Association
;; Produces the first Association
;; whose first item is equal to key,
;; or default if there is no such Association.
(check-expect (find-association "Name" '() 0) (list "Name" 0))
(check-expect (find-association "Name" LASSOC1 "Default") (list "Name" "Joyful Sonata"))
(check-expect (find-association "Bit Rate" LASSOC1 "Default") (list "Bit Rate" "Default"))
(check-expect (find-association "Play Count" LASSOC1 100) (list "Play Count" 77))
(check-expect (find-association "Date Added" LASSOC1 DATE2) (list "Date Added" DATE1))
(define (find-association key lassoc default)
  (cond
    [(empty? lassoc) (list key default)]
    [(string=? key (first (first lassoc))) (first lassoc)]
    [else (find-association key (rest lassoc) default)]))

