;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-201) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 201.
;; Design select-all-album-titles.
;; The function consumes an LTracks
;; and produces the list of album titles as a List-of-strings.
;; Also design create-set.
;; It consumes a List-of-strings and constructs one
;; that contains every String from the given list exactly once.
;; Finally design select-album-titles/unique,
;; which consumes an LTracks and produces a list of unique album titles.


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

;; LTracks -> List-of-strings
;; Produces the list of the given tracks album titles.
(check-expect (select-all-album-titles '()) '())
(check-expect (select-all-album-titles LTRACKS) (list "Joyful Sonata" "Believer"))
(define (select-all-album-titles tracks)
  (cond
    [(empty? tracks) '()]
    [else (cons (track-name (first tracks)) (select-all-album-titles (rest tracks)))]))

;; List-of-strings -> List-of-strings
;; Produces a list of unique strings.
(check-expect (create-set '()) '())
(check-expect (create-set (list "a")) (list "a"))
(check-expect (create-set (list "a" "a")) (list "a"))
(check-expect (create-set (list "a" "a" "b")) (list "a" "b"))
(check-expect (create-set (list "b" "a" "b" "a")) (list "b" "a"))
(define (create-set l)
  (cond
    [(empty? l) '()]
    [else (if (member? (first l) (rest l))
              (create-set (rest l))
              (cons (first l) (create-set (rest l))))]))

;; LTracks -> List-of-strings
;; Produces a list of unique album titles.
(check-expect (select-album-titles/unique '()) '())
(check-expect (select-album-titles/unique LTRACKS) (list "Joyful Sonata" "Believer"))
(check-expect (select-album-titles/unique (list TRACK1 TRACK2 TRACK1))
              (list "Believer" "Joyful Sonata"))
(define (select-album-titles/unique tracks)
  (create-set (select-all-album-titles tracks)))


;;; Application

;(select-all-album-titles itunes-tracks)
;(select-album-titles/unique itunes-tracks)

