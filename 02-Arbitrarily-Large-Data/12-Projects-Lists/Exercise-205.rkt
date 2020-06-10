;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-205) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 205.
;; Develop examples of LAssoc and LLists,
;; that is, the list representation of tracks and lists of such tracks.


(require 2htdp/itunes)


;; year month day hour minute second
(define DATE1 (create-date 2020 2 20 12 0 0))
(define DATE2 (create-date 2020 5 15 23 15 30))
(define DATE3 (create-date 2019 12 5 1 20 44))
(define DATE4 (create-date 2020 6 2 5 15 4))
(define DATE5 (create-date 2020 6 7 8 8 3))

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
   (list "Date Modified" DATE4)))

(define LASSOC2
  (list
   (list "Track ID" 2)
   (list "Name" "Believer")
   (list "Artist" "Imagine Dragons")
   (list "Album" "Evolve")
   (list "Total Time" 204000)
   (list "Track Number" 3)
   (list "Date Added" DATE3)
   (list "Play Count" 82)
   (list "Date Modified" DATE2)))

(define LASSOC3
  (list
   (list "Track ID" 3)
   (list "Name" "Whatever It Takes")
   (list "Artist" "Imagine Dragons")
   (list "Album" "Evolve")
   (list "Total Time" 201000)
   (list "Track Number" 2)
   (list "Date Added" DATE3)
   (list "Play Count" 80)
   (list "Date Modified" DATE5)))

(define LLISTS1
  (list LASSOC1 LASSOC2 LASSOC3))

