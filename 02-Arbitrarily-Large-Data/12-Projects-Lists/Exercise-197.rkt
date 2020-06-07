;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-197) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 197.
;; Design most-frequent. The function consumes a Dictionary.
;; It produces the Letter-Count for the letter
;; that occurs most often as the first one in the given Dictionary.
;; What is the most frequently used letter
;; in your computer’s dictionary and how often is it used?


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

(define-struct lc [letter count])
;; An LC (short for Letter Count) is a structure:
;;  (make-lc Letter PositiveNumber)

;; An LLC is one of:
;; - '()
;; - (cons LC LLC)

;; NE-LLC is a non-empty LLC.

(define ERROR-EMPTY-DICT "most-frequent: accepts a non-empty Dictionary")


;;; Functions

;; Dictionary -> LC
;; Produces the LC for the letter that occurs most often
;; as the first one in the given Dictionary d.
(check-error (most-frequent '()) ERROR-EMPTY-DICT)
(check-expect (most-frequent (list "cat")) (make-lc "c" 1))
(check-expect (most-frequent (list "cat" "cheetah")) (make-lc "c" 2))
(check-expect (most-frequent (list "cat" "cheetah" "dog")) (make-lc "c" 2))
;; For simplicity, we do not specifically handle letters with equal frequencies.
(check-expect (most-frequent (list "cat" "cheetah" "dog" "zombi" "zoo")) (make-lc "z" 2))
;; Also supports not sorted Dicstionaries at the cost of some performance.
(check-expect (most-frequent (list "zombi" "cheetah" "zoo" "cat" "dog")) (make-lc "c" 2))
(define (most-frequent d)
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

;(most-frequent (list "cat" "dog" "cheetah" "abba" "menu" "mine" "do" "re" "mi"))

;; In accordance with the chapter intro,
;; the performance issues are not addressed specifically.
;(most-frequent AS-LIST)


;;; Answer 1
;; The most frequently used letter is "s".
;; It occurs - as the first one - 22759 times.

;;; Answer 2
;; Pick the pair with the maximum count to achieve better performance.
;; Select the first from a sorted list of pairs when the sorting function
;; can be potentially used by other parts of the code too.

