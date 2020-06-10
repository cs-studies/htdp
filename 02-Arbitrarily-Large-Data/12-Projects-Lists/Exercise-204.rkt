;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-204) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 204.
;; Design select-albums.
;; The function consumes an element of LTracks.
;; It produces a list of LTracks, one per album.
;; Each album is uniquely identified by its title
;; and shows up in the result only once.


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
  (create-date 2020 6 7 8 8 3))

;; name artist album time track# added play# played
(define TRACK1
  (create-track "Joyful Sonata" "T. Nikolayeva" "The Best of Piano" 301641 44 DATE1 77 DATE4))
(define TRACK2
  (create-track "Believer" "Imagine Dragons" "Evolve" 204000 102 DATE3 82 DATE2))
(define TRACK3
  (create-track "Whatever It Takes" "Imagine Dragons" "Evolve" 201000 101 DATE3 80 DATE5))

(define LTRACKS (list TRACK1 TRACK3 TRACK2))


;;; Functions

;; LTracks -> LTracks
;; Selects one track from each album.
(check-expect (select-albums '()) '())
(check-expect (select-albums (list TRACK1)) (list TRACK1))
(check-expect (select-albums (list TRACK1 TRACK2)) (list TRACK1 TRACK2))
(check-expect (select-albums (list TRACK1 TRACK2 TRACK3)) (list TRACK1 TRACK3))
(define (select-albums tracks)
  (cond
    [(empty? tracks) '()]
    [else (if (member-by-album? (first tracks) (rest tracks))
              (select-albums (rest tracks))
              (cons (first tracks) (select-albums (rest tracks))))]))

;; Track LTracks -> Boolean
;; Determines whether the tracks list
;; contains other tracks from the t track album.
(check-expect (member-by-album? TRACK1 '()) #false)
(check-expect (member-by-album? TRACK1 (list TRACK2 TRACK3)) #false)
(check-expect (member-by-album? TRACK2 (list TRACK3)) #true)
(check-expect (member-by-album? TRACK2 (list TRACK1 TRACK3)) #true)
(define (member-by-album? t tracks)
  (cond
    [(empty? tracks) #false]
    [else (if (album=? t (first tracks))
              #true
              (member-by-album? t (rest tracks)))]))

;; Track Track -> Boolean
;; Determines whether the tracks belong to the same album.
(check-expect (album=? TRACK1 TRACK1) #true)
(check-expect (album=? TRACK2 TRACK3) #true)
(check-expect (album=? TRACK1 TRACK3) #false)
(define (album=? t1 t2)
  (string=? (track-album t1) (track-album t2)))

