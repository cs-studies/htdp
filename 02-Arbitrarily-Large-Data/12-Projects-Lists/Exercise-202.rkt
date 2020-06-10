;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-202) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 202.
;; Design select-album.
;; The function consumes the title of an album and an LTracks.
;; It extracts from the latter the list of tracks that belong to the given album.


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
(define DATE5
  (create-date 2020 6 2 5 18 3))

;; name artist album time track# added play# played
(define TRACK1
  (create-track "Joyful Sonata" "T. Nikolayeva" "The Best of Piano" 301641 44 DATE1 77 DATE2))
(define TRACK2
  (create-track "Believer" "Imagine Dragons" "Evolve" 204000 102 DATE3 82 DATE4))
(define TRACK3
  (create-track "Whatever It Takes" "Imagine Dragons" "Evolve" 201000 101 DATE3 80 DATE5))

(define LTRACKS (list TRACK1 TRACK3 TRACK2))


;; String LTracks -> LTracks
;; Exctacts the list of tracks by the album title.
(check-expect (select-album "Evolve" '()) '())
(check-expect (select-album "Origins" LTRACKS) '())
(check-expect (select-album "Evolve" LTRACKS) (list TRACK3 TRACK2))
(define (select-album title tracks)
  (cond
    [(empty? tracks) '()]
    [else (if (in-album? title (first tracks))
              (cons (first tracks) (select-album title (rest tracks)))
              (select-album title (rest tracks)))]))

;; String Track -> Boolean
;; Determines whether the track belongs to the album.
(check-expect (in-album? "Evolve" TRACK1) #false)
(check-expect (in-album? "Evolve" TRACK2) #true)
(define (in-album? title t)
  (string=? title (track-album t)))

