;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-196) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 196.
;; Design count-by-letter.
;; The function consumes a Dictionary and counts how often each letter
;; is used as the first one of a word in the given dictionary.
;; Its result is a list of Letter-Counts,
;; a piece of data that combines letters and counts.


(require 2htdp/batch-io)


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

;; A List-of-LC is one of:
;; - '()
;; - (cons LC List-of-LC)


;; Dictionary -> List-of-LC
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

;; Letter List-of-LC -> List-of-LC
;; Inserts or increments a letter count on the list l-lc.
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
(define (count-letter l l-lc)
  (if (member? l LETTERS)
      (cond
        [(empty? l-lc) (cons (make-lc l 1) '())]
        [else (if (string=? l (lc-letter (first l-lc)))
                  (cons (make-lc l (add1 (lc-count (first l-lc)))) (rest l-lc))
                  (cons (first l-lc) (count-letter l (rest l-lc))))])
      l-lc))


;;; Application

;(count-by-letter (list "cat" "dog" "cheetah" "abba" "menu" "mine" "do" "re" "mi"))

;; In accordance with this chapter intro,
;; the performance is not tried to be made perfect.
;; Still, a relatively tolerable performance approach was chosen.
;(count-by-letter AS-LIST)

;;(count-by-letter (reverse AS-LIST))

