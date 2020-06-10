;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-203) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 203.
;; Design select-album-date.
;; The function consumes the title of an album, a date, and an LTracks.
;; It extracts from the latter the list of tracks
;; that belong to the given album and have been played after the given date.


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
(define DATE6
  (create-date 2020 6 23 23 59 59))


;; name artist album time track# added play# played
(define TRACK1
  (create-track "Joyful Sonata" "T. Nikolayeva" "The Best of Piano" 301641 44 DATE1 77 DATE4))
(define TRACK2
  (create-track "Believer" "Imagine Dragons" "Evolve" 204000 102 DATE3 82 DATE2))
(define TRACK3
  (create-track "Whatever It Takes" "Imagine Dragons" "Evolve" 201000 101 DATE3 80 DATE5))

(define LTRACKS (list TRACK1 TRACK3 TRACK2))


;; String Date LTracks -> LTracks
;; Exctacts the list of tracks:
;; - played after the date
;; - belonging to the album.
(check-expect (select-album-date "Evolve" DATE3 '()) '())
(check-expect (select-album-date "Origins" DATE3 LTRACKS) '())
(check-expect (select-album-date "Evolve" DATE6 LTRACKS) '())
(check-expect (select-album-date "Evolve" DATE3 LTRACKS) (list TRACK3 TRACK2))
(check-expect (select-album-date "Evolve" DATE4 LTRACKS) (list TRACK3))
(define (select-album-date title date tracks)
  (cond
    [(empty? tracks) '()]
    [else (if (and
               (in-album? title (first tracks))
               (date<? date (track-played (first tracks))))
              (cons (first tracks) (select-album-date title date (rest tracks)))
              (select-album-date title date (rest tracks)))]))

;; String Track -> Boolean
;; Determines whether the track belongs to the album.
(check-expect (in-album? "Evolve" TRACK1) #false)
(check-expect (in-album? "Evolve" TRACK2) #true)
(define (in-album? title t)
  (string=? title (track-album t)))

;; Date Date -> Boolean
;; Determines whether the first date occurs before the second.
(check-expect (date<? DATE6 DATE3) #false)
(check-expect (date<? DATE4 DATE5) #true)
(check-expect (date<? (create-date 2020 6 1 10 11 11) (create-date 2020 6 1 10 11 12)) #true)
(check-expect (date<? (create-date 2020 6 1 10 11 11) (create-date 2020 6 1 10 11 11)) #false)
(check-expect (date<? (create-date 2020 6 1 10 11 11) (create-date 2020 7 1 10 11 11)) #true)
(define (date<? d1 d2)
  (cond
    [(< (date-year d1) (date-year d2)) #true]
    [(= (date-year d1) (date-year d2))
     (cond
       [(< (date-month d1) (date-month d2)) #true]
       [(= (date-month d1) (date-month d2))
        (< (daytime->seconds d1) (daytime->seconds d2))]
       [else #false])]
    [else #false]))

;; Date -> Number
;; Converts the day and time of the given date
;; into the number of seconds.
(check-expect (daytime->seconds (create-date 1970 1 1 0 0 0)) 0)
(check-expect (daytime->seconds (create-date 1970 1 1 0 0 1)) 1)
(check-expect (daytime->seconds (create-date 1970 1 1 0 1 0)) 60)
(check-expect (daytime->seconds (create-date 1970 1 1 1 0 0)) 3600)
(check-expect (daytime->seconds (create-date 1970 1 2 0 0 0)) 86400)
(define (daytime->seconds d)
  (+
   (* 60 60 24 (- (date-day d) 1))
   (* 60 60 (date-hour d))
   (* 60 (date-minute d))
   (date-second d)))

