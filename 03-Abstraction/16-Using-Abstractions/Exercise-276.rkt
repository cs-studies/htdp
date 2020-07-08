;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-276) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 276.
;; Design select-album-date (see exercise 203).
;; Design select-albums (see exercise 204).


(require 2htdp/itunes)


;;; Data Definitions

;; A Date is a structure:
;;   (make-date N N N N N N)

;; A Track is a structure:
;;   (make-track String String String N N Date N Date)

;; An LTracks is one of:
;; – '()
;; – (cons Track LTracks)


;;; Constants

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


;;; Functions

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
  (local (;; Track -> Boolean
          (define (by-album-and-date track)
            (and
             (string=? title (track-album track))
             (date<? date (track-played track))))

          ;; Date Date -> Boolean
          (define (date<? d1 d2)
            (local (;; Date -> Number
                    (define (daytime->seconds d)
                      (+
                       (* 60 60 24 (- (date-day d) 1))
                       (* 60 60 (date-hour d))
                       (* 60 (date-minute d))
                       (date-second d))))
              (cond
                [(< (date-year d1) (date-year d2)) #true]
                [(= (date-year d1) (date-year d2))
                 (cond
                   [(< (date-month d1) (date-month d2)) #true]
                   [(= (date-month d1) (date-month d2))
                    (< (daytime->seconds d1) (daytime->seconds d2))]
                   [else #false])]
                [else #false]))))
    (filter by-album-and-date tracks)))


;; LTracks -> LTracks
;; Selects one track from each album.
(check-expect (select-albums '()) '())
(check-expect (select-albums (list TRACK1)) (list TRACK1))
(check-expect (select-albums (list TRACK1 TRACK2)) (list TRACK1 TRACK2))
(check-expect (select-albums (list TRACK1 TRACK2 TRACK3)) (list TRACK1 TRACK3))
(define (select-albums tracks)
  (local (;; Track LTracks -> LTracks
          (define (traverse t l)
            (local (;; Track -> Boolean
                    (define (member-by-album? i)
                      (string=? (track-album i) (track-album t))))
              (if (ormap member-by-album? l) l (cons t l)))))
    (foldr traverse '() tracks)))


;;; Application

;(select-album-date "Evolve" DATE4 LTRACKS)
;(select-albums (list TRACK1 TRACK2 TRACK3))

