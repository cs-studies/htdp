;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-259) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 259.
;; Use a local expression to organize the functions
;; for rearranging words from Word Games, the Heart of the Problem.


(require 2htdp/batch-io)


;; On OS X:
(define LOCATION "/usr/share/dict/words")
;; On LINUX: /usr/share/dict/words or /var/lib/dict/words
;; On WINDOWS: borrow the word file from your Linux friend

(define DICTIONARY (read-lines LOCATION))


;; String -> [List-of String]
;; Finds all words that use the same letters as s.
(check-member-of (alternative-words "cat")
                 (list "act" "cat")
                 (list "cat" "act"))
(check-satisfied (alternative-words "dear") words-from-dear?)
(define (alternative-words s0)
  (local (
          ;; String -> [List-of String]
          (define (find-alternative-words s)
            (in-dictionary (words->strings (arrangements (explode s)))))

          ;; [List-of [List-of 1String]] -> [List-of String]
          ;; Converts low to a list of strings.
          (define (words->strings low)
            (cond
              [(or (empty? low) (empty? (first low))) '()]
              [else (cons (implode (first low)) (words->strings (rest low)))]))

          ;; [List-of 1String] -> [List-of [List-of 1String]]
          ;; Creates all rearrangements of the letters in w.
          (define (arrangements w)
            (local (
                    ;; 1String [List-of [List-of 1String]] -> [List-of [List-of 1String]]
                    ;; Produces a list of words like the given low
                    ;; but with the given letter inserted
                    ;; at the beginning, between all letters,
                    ;; and at the end of all words of the low.
                    (define (insert-everywhere/in-all-words letter low)
                      (cond
                        [(empty? low) '()]
                        [else (append (insert-everywhere letter '() (first low))
                                      (insert-everywhere/in-all-words letter (rest low)))]))

                    ;; 1String [List-of 1String] [List-of 1String] -> [List-of [List-of 1String]]
                    ;; Produces a list of words by inserting
                    ;; the letter at all the possible positions
                    ;; between the prefix and suffix lists letters.
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
                           (rest suffix)))])))
              (cond
                [(empty? w) (list '())]
                [else (insert-everywhere/in-all-words
                       (first w)
                       (arrangements (rest w)))]))))
    (find-alternative-words s0)))

;; [List-of String] -> Boolean
;; Helps to test alternative-words function.
;; A dictionary may contain more matching words.
(define (words-from-dear? w)
  (and (member? "dear" w) (member? "read" w) (member? "dare" w)))

;; [List-of String] -> [List-of String]
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


;;; Application

;(alternative-words "dear")

;(alternative-words "art")

;(alternative-words "tea")

