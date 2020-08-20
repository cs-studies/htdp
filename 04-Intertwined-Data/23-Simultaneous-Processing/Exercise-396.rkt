;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-396) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 396.
;; Figure 136 presents the essence of a time-limited version of the Hangman game.
;; Design compare-word, the central function.
;; It consumes the word to be guessed,
;; a word s that represents how much/little the guessing player has discovered,
;; and the current guess.
;; The function produces s with all "_" where the guess revealed a letter.


(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)


;;; Data Definitions

;; An HM-Word is a [List-of Letter or "_"]
;; "_" represents a letter to be guessed.


;;; Constants

(define LOCATION "/usr/share/dict/words") ; on OS X
(define AS-LIST (read-lines LOCATION))
(define SIZE (length AS-LIST))
(define LETTERS (explode "abcdefghijklmnopqrstuvwxyz"))


;;; Functions

;; HM-Word N -> String
;; Runs a simplistic hangman game, produces the current state.
(define (play the-pick time-limit)
  (local ((define the-word  (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          ;; HM-Word -> HM-Word
          (define (do-nothing s) s)
          ;; HM-Word KeyEvent -> HM-Word
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status)))
    (implode
     (big-bang the-guess ;; HM-Word
       [to-draw render-word]
       [on-tick do-nothing 1 time-limit]
       [on-key  checked-compare]))))

;; HM-Word -> Image
(define (render-word w)
  (text (implode w) 22 "black"))

;; Word Word 1String -> Word
;; Produces Word with the revealed letters
(check-expect (compare-word '("c" "a" "t") '("_" "_" "_") "b") '("_" "_" "_"))
(check-expect (compare-word '("c" "a" "t") '("_" "_" "_") "a") '("_" "a" "_"))
(check-expect (compare-word '("a" "b" "a") '("_" "b" "_") "a") '("a" "b" "a"))
(define (compare-word the-word s current-guess)
  (cond
    [(empty? the-word) '()]
    [else (cons (if (string=? (first the-word) current-guess)
                    current-guess
                    (first s))
                (compare-word (rest the-word) (rest s) current-guess))]))


;;; Application

(play (list-ref AS-LIST (random SIZE)) 30)

