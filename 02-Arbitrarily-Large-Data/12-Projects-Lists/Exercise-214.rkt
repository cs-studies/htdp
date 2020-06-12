;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-214) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 214.
;; Integrate arrangements with the partial program
;; from Word Games, Composition Illustrated.
;; After making sure that the entire suite of tests passes,
;; run it on some of your favorite examples.


(require 2htdp/batch-io)


;;; Data Definitions

;; A Word is one of:
;; – '()
;; – (cons 1String Word)
;; Represents a list of 1Strings (letters).

;; A List-of-words is one of:
;; - (cons Word '())
;; - (cons Word List-of-words)


;;; Constants

;; On OS X:
(define LOCATION "/usr/share/dict/words")
;; On LINUX: /usr/share/dict/words or /var/lib/dict/words
;; On WINDOWS: borrow the word file from your Linux friend

(define DICTIONARY (read-lines LOCATION))


;;; Functions

;; String -> List-of-strings
;; Finds all words that use the same letters as s.
(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
(check-satisfied (alternative-words "dear") words-from-dear?)
(define (alternative-words s)
  (in-dictionary
   (words->strings (arrangements (string->word s)))))

;; List-of-strings -> Boolean
;; Helps to test alternative-words function.
;; A dictionary may contain more matching words.
(define (words-from-dear? w)
  (and (member? "dear" w) (member? "read" w) (member? "dare" w)))

;; List-of-strings -> List-of-strings
;; Picks out all those Strings that occur in the dictionary.
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "cat")) (list "cat"))
(check-expect (in-dictionary (list "cat" "ttc" "dog")) (list "cat" "dog"))
(define (in-dictionary los)
  (cond
    [(empty? los) '()]
    [else (if (member? (first los) DICTIONARY)
               (cons (first los) (in-dictionary (rest los)))
               (in-dictionary (rest los)))]))

;; List-of-words -> List-of-strings
;; Converts low to a list of strings.
(check-expect (words->strings (list '())) '())
(check-expect (words->strings (list (list "a"))) (list "a"))
(check-expect (words->strings (list (list "c" "a" "t"))) (list "cat"))
(check-expect (words->strings (list (list "c" "a" "t") (list "d" "o" "g"))) (list "cat" "dog"))
(define (words->strings low)
  (cond
    [(or (empty? low) (empty? (first low))) '()]
    [else (cons (word->string (first low)) (words->strings (rest low)))]))

;; Word -> String
;; Converts w to a string.
(check-expect (word->string '()) "")
(check-expect (word->string (cons "a" '())) "a")
(check-expect (word->string (list "a" "b")) "ab")
(check-expect (word->string (list "a" "b" "c")) "abc")
(define (word->string w)
  (implode w))

;; Word -> List-of-words
;; Creates all rearrangements of the letters in w.
(check-expect (arrangements '()) (list '()))
(check-expect (arrangements (list "d")) (list (list "d")))
(check-expect (arrangements (list "d" "e")) (list (list "d" "e") (list "e" "d")))
(check-expect (arrangements (list "d" "e" "r"))
              (list
               (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")
               (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
(define (arrangements w)
  (cond
    [(empty? w) (list '())]
    [else (insert-everywhere/in-all-words
           (first w)
           (arrangements (rest w)))]))

;; 1String List-of-words -> List-of-words
;; Produces a list of words like the given low
;; but with the given letter inserted
;; at the beginning, between all letters,
;; and at the end of all words of the low.
(check-expect (insert-everywhere/in-all-words "d" (list '())) (list (list "d")))
(check-expect (insert-everywhere/in-all-words "d" (list (list "e")))
              (list (list "d" "e") (list "e" "d")))
(check-expect (insert-everywhere/in-all-words "d" (list (list "e") (list "r")))
              (list (list "d" "e") (list "e" "d") (list "d" "r") (list "r" "d")))
(check-expect (insert-everywhere/in-all-words "d" (list (list "e" "r") (list "r" "e")))
              (list
               (list "d" "e" "r") (list "e" "d" "r") (list "e" "r" "d")
               (list "d" "r" "e") (list "r" "d" "e") (list "r" "e" "d")))
(define (insert-everywhere/in-all-words letter low)
  (cond
    [(empty? low) '()]
    [else (append (insert-everywhere letter '() (first low))
           (insert-everywhere/in-all-words letter (rest low)))]))

;; 1String Word Word -> List-of-words
;; Produces a list of words by inserting
;; the letter at all the possible positions
;; between the prefix and suffix lists letters.
(check-expect (insert-everywhere "d" '() '()) (list (list "d")))
(check-expect (insert-everywhere "d" '() (list "a"))
              (list (list "d" "a") (list "a" "d")))
(check-expect (insert-everywhere "d" '() (list "a" "e"))
              (list (list "d" "a" "e") (list "a" "d" "e") (list "a" "e" "d")))
(check-expect (insert-everywhere "d" '() (list "a" "e" "r"))
              (list
               (list "d" "a" "e" "r")
               (list "a" "d" "e" "r")
               (list "a" "e" "d" "r")
               (list "a" "e" "r" "d")))
(define (insert-everywhere letter prefix suffix)
  (cond
    [(empty? suffix)
     (list (append prefix (list letter)))]
    [else
     (append
      (list (append prefix (list letter) suffix))
      (insert-everywhere
       letter
       (append prefix (list (first suffix)))
       (rest suffix)))]))

;; String -> Word
;; Converts s to the chosen word representation.
(check-expect (string->word "") '())
(check-expect (string->word "a") (cons "a" '()))
(check-expect (string->word "ab") (list "a" "b"))
(check-expect (string->word "abc") (list "a" "b" "c"))
(define (string->word s)
  (explode s))


;;; Application

;(alternative-words "dear")

;(alternative-words "art")

;(alternative-words "tea")

