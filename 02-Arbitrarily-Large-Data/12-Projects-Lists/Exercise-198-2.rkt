;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-198-2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 198.
;; Redesign most-frequent from exercise 197 using words-by-first-letter.


(require 2htdp/batch-io)


;;; Constants and Data Definitions

;; On OS X:
(define LOCATION "/usr/share/dict/words")
;; On LINUX: /usr/share/dict/words or /var/lib/dict/words
;; On WINDOWS: borrow the word file from your Linux friend

;; A Dictionary is a List-of-strings.
(define AS-LIST (read-lines LOCATION))

;; A Letter is one of the following 1Strings:
;; – "a"
;; – ...
;; – "z"
;; or, equivalently, a member? of this list:
(define LETTERS
  (explode "abcdefghijklmnopqrstuvwxyz"))

;; An LoD is a list of Dictionaries, one per Letter.
;; For example,
;; (list
;;   (list "q-word-first" ... "q-word-last")
;;   (list "k-word-first" ... "k-word-last"))

(define-struct lc [letter count])
;; An LC (short for Letter Count) is a structure:
;;  (make-lc Letter PositiveNumber)

;; An LLC is one of:
;; - '()
;; - (cons LC LLC)

;; NE-LLC is a non-empty LLC.

(define ERROR-EMPTY-DICT "most-frequent: accepts a non-empty Dictionary")

(define ERROR-EMPTY-WORD "first-letter: accepts a non-empty String")


;;; Functions

;;; most-frequent.v2

;; Dictionary -> LC
;; Produces the LC for the letter that occurs most often
;; in the given Dictionary d.
(check-error (most-frequent.v2 '()) ERROR-EMPTY-DICT)
(check-expect (most-frequent.v2 (list "cat")) (make-lc "c" 1))
(check-expect (most-frequent.v2 (list "cat" "cheetah")) (make-lc "c" 2))
(check-expect (most-frequent.v2 (list "cat" "cheetah" "dog")) (make-lc "c" 2))
(check-expect (most-frequent.v2 (list "cat" "cheetah" "dog" "zombi" "zoo")) (make-lc "z" 2))
(check-expect (most-frequent.v2 (list "zombi" "cheetah" "zoo" "cat" "dog" "cute"))
              (make-lc "c" 3))
(define (most-frequent.v2 d)
  (cond
    [(empty? d) (error ERROR-EMPTY-DICT)]
    [else (dict->lc (max-length (words-by-first-letter d)))]))

;; Dictionary -> LC
;; Produces LC based on the Dictionary data.
(check-expect (dict->lc (list "cat")) (make-lc "c" 1))
(check-expect (dict->lc (list "cat" "cheetah")) (make-lc "c" 2))
(define (dict->lc d)
  (make-lc (first-letter (first d)) (length d)))

;; LoD -> Dictionary
;; Picks the largest Dictionary on the list.
(check-expect (max-length (list (list "a"))) (list "a"))
(check-expect (max-length (list (list "a" "am") (list "b"))) (list "a" "am"))
(check-expect (max-length (list (list "a" "am") (list "b" "back"))) (list "a" "am"))
(check-expect (max-length (list (list "a" "am") (list "b" "back" "bold"))) (list "b" "back" "bold"))
(define (max-length ld)
  (cond
    [(empty? (rest ld)) (first ld)]
    [else (select-larger (first ld) (max-length (rest ld)))]))

;; Dictionary Dictionary -> Dictionary
;; Selects a larger Dictionary.
(check-expect (select-larger (list "a" "am") (list "b")) (list "a" "am"))
(check-expect (select-larger (list "a") (list "b" "back")) (list "b" "back"))
(check-expect (select-larger (list "a") (list "b")) (list "a"))
(define (select-larger d1 d2)
  (if (>= (length d1) (length d2)) d1 d2))

;; Dictionary -> LoD
;; Produces LoD from a given Dictionary d.
(check-expect (words-by-first-letter '()) '())
(check-expect (words-by-first-letter (list "a")) (list (list "a")))
(check-expect (words-by-first-letter (list "a" "am")) (list (list "a" "am")))
(check-expect (words-by-first-letter (list "a" "b")) (list (list "b") (list "a")))
(check-expect (words-by-first-letter (list "a" "am" "b"))
              (list (list "b") (list "a" "am")))
(check-expect (words-by-first-letter (list "a" "am" "b" "back"))
              (list (list "b" "back") (list "a" "am")))
(define (words-by-first-letter d)
  (cond
    [(empty? d) '()]
    [else (put (first d) (words-by-first-letter (rest d)))]))

;; String LLC -> LLC
;; Adds the word to the given LLC by the word's first letter.
(check-expect (put "a" '()) (list (list "a")))
(check-expect (put "a" (list '())) (list (list "a")))
(check-expect (put "am" (list (list "a"))) (list (list "am" "a")))
(check-expect (put "b" (list (list "a"))) (list (list "a") (list "b")))
(check-expect (put "b" (list (list "a" "am"))) (list (list "a" "am") (list "b")))
(check-expect (put "back" (list (list "a" "am") (list "b")))
              (list (list "a" "am") (list "back" "b")))
(check-expect (put "-" (list (list "a"))) (list (list "a")))
(define (put word llc)
  (if (not (member? (first-letter word) LETTERS))
      llc
      (cond
        [(or (empty? llc) (empty? (first llc))) (list (list word))]
        [else (if (string=? (first-letter word) (first-letter (first (first llc))))
                  (cons (cons word (first llc)) (rest llc))
                  (cons (first llc) (put word (rest llc))))])))

;; String -> Letter
;; Produces the first letter of the given word.
(check-error (first-letter "") ERROR-EMPTY-WORD)
(check-expect (first-letter "a") "a")
(check-expect (first-letter "cat") "c")
(define (first-letter word)
  (cond
    [(string=? "" word) (error ERROR-EMPTY-WORD)]
    [else (string-ith word 0)]))


;;; most-frequent.v1

;; Dictionary -> LC
;; Produces the LC for the letter that occurs most often
;; in the given Dictionary d.
(check-error (most-frequent.v1 '()) ERROR-EMPTY-DICT)
(check-expect (most-frequent.v1 (list "cat")) (make-lc "c" 1))
(check-expect (most-frequent.v1 (list "cat" "cheetah")) (make-lc "c" 2))
(check-expect (most-frequent.v1 (list "cat" "cheetah" "dog")) (make-lc "c" 2))
(check-expect (most-frequent.v1 (list "cat" "cheetah" "dog" "zombi" "zoo")) (make-lc "z" 2))
(check-expect (most-frequent.v1 (list "zombi" "cheetah" "zoo" "cat" "dog" "cute"))
              (make-lc "c" 3))
(define (most-frequent.v1 d)
  (cond
    [(empty? d) (error ERROR-EMPTY-DICT)]
    [else (max-count (count-by-letter d))]))

;; NE-LLC -> LC
;; Picks an LC with the maximum count.
(check-expect (max-count (list (make-lc "c" 1))) (make-lc "c" 1))
(check-expect (max-count (list (make-lc "c" 2) (make-lc "b" 1))) (make-lc "c" 2))
(check-expect (max-count (list (make-lc "c" 1) (make-lc "b" 2))) (make-lc "b" 2))
(check-expect (max-count (list (make-lc "c" 1) (make-lc "b" 1))) (make-lc "c" 1))
(check-expect (max-count (list (make-lc "a" 1) (make-lc "b" 3) (make-lc "c" 2))) (make-lc "b" 3))
(define (max-count llc)
  (cond
    [(empty? (rest llc)) (first llc)]
    [else (select-max (first llc) (max-count (rest llc)))]))

;; LC LC -> LC
;; Returns an LC with a larger count value.
(check-expect (select-max (make-lc "a" 1) (make-lc "b" 2)) (make-lc "b" 2))
(check-expect (select-max (make-lc "a" 2) (make-lc "b" 1)) (make-lc "a" 2))
(check-expect (select-max (make-lc "a" 3) (make-lc "b" 3)) (make-lc "a" 3))
(define (select-max lc1 lc2)
  (if (>= (lc-count lc1) (lc-count lc2)) lc1 lc2))

;; Dictionary -> LLC
;; Counts how often a letter is used as the first one
;; of a word in the given dictionary.
(check-expect (count-by-letter '()) '())
(check-expect (count-by-letter (list "cat")) (list (make-lc "c" 1)))
(check-expect (count-by-letter (list "cat" "cheetah")) (list (make-lc "c" 2)))
(check-expect (count-by-letter (list "cat" "cheetah" "dog"))
              (list (make-lc "d" 1) (make-lc "c" 2)))
(check-expect (count-by-letter (list "cat" "cheetah" "dog" "zombi" "zoo"))
              (list (make-lc "z" 2) (make-lc "d" 1) (make-lc "c" 2)))
;; Also supports not sorted Dicstionaries at the cost of some performance.
(check-expect (count-by-letter (list "zombi" "cheetah" "zoo" "cat" "dog"))
              (list (make-lc "d" 1) (make-lc "c" 2) (make-lc "z" 2)))
(define (count-by-letter d)
  (cond
    [(empty? d) '()]
    [else (count-letter (string-ith (first d) 0) (count-by-letter (rest d)))]))

;; Letter LLC -> LLC
;; Inserts or increments a letter count on the list llc.
(check-expect (count-letter "c" '()) (list (make-lc "c" 1)))
(check-expect (count-letter "c" (list (make-lc "c" 1)))
              (list (make-lc "c" 2)))
(check-expect (count-letter "c" (list (make-lc "d" 1)))
              (list (make-lc "d" 1) (make-lc "c" 1)))
(check-expect (count-letter "c" (list (make-lc "c" 1) (make-lc "d" 1)))
              (list (make-lc "c" 2) (make-lc "d" 1)))
(check-expect (count-letter "c" (list (make-lc "d" 1) (make-lc "c" 1)))
              (list (make-lc "d" 1) (make-lc "c" 2)))
(check-expect (count-letter "A" (list (make-lc "d" 1) (make-lc "c" 1)))
              (list (make-lc "d" 1) (make-lc "c" 1)))
(define (count-letter l llc)
  (if (member? l LETTERS)
      (cond
        [(empty? llc) (cons (make-lc l 1) '())]
        [else (if (string=? l (lc-letter (first llc)))
                  (cons (make-lc l (add1 (lc-count (first llc)))) (rest llc))
                  (cons (first llc) (count-letter l (rest llc))))])
      llc))


;;; Application

;(define test-dict (list "cat" "dog" "cheetah" "abba" "menu" "mine" "do" "re" "mi"))
;(check-expect (most-frequent.v1 test-dict) (most-frequent.v2 test-dict))

;(check-expect (most-frequent.v1 AS-LIST) (most-frequent.v2 AS-LIST))

