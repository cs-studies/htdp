;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-199) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 199.
;; Make up examples of Dates, Tracks, and LTracks.


(require 2htdp/itunes)


;; year month day hour minute second
(define DATE1
  (create-date 2020 2 20 12 0 0))
(define DATE2
  (create-date 2020 5 15 23 15 30))
(define DATE3
  (create-date 2019 12 5 1 20 44))
(define DATE4
  (create-date 2020 6 2 5 15 4))

;; name artist album time track# added play# played
(define TRACK1
  (create-track "Joyful Sonata" "T. Nikolayeva" "The Best of Piano" 301641 44 DATE1 77 DATE2))
(define TRACK2
  (create-track "Believer" "Imagine Dragons" "Evolve" 204000 102 DATE3 82 DATE4))

(define LTRACKS1 '())
(define LTRACKS2 (list TRACK1 TRACK2))

