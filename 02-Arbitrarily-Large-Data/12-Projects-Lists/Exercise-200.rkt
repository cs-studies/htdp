;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-200) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 200.
;; Design the function total-time,
;; which consumes an element of LTracks
;; and produces the total amount of play time.


(require 2htdp/itunes)


;;; Constants

(define ITUNES-LOCATION "./files/itunes.xml")

; LTracks
(define itunes-tracks
  (read-itunes-as-tracks ITUNES-LOCATION))


;;; Tests Data

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

(define LTRACKS (list TRACK1 TRACK2))


;;; Functions

;; LTracks -> Number
;; Produces the total amount of play time of the given list of tracks.
(check-expect (total-time '()) 0)
(check-expect (total-time LTRACKS) 505641)
(define (total-time tracks)
  (cond
    [(empty? tracks) 0]
    [else (+ (track-time (first tracks)) (total-time (rest tracks)))]))


;;; Application

;(total-time itunes-tracks)

