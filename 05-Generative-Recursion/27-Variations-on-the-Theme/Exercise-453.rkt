;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-453) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 453.
;; Design the function tokenize.
;; It turns a Line into a list of tokens.
;; Here a token is either a 1String
;; or a String that consists of lower-case letters and nothing else.
;; That is, all white-space 1Strings are dropped;
;; all other non-letters remain as is;
;; and all consecutive letters are bundled into “words.”


;; A Line is a [List-of 1String]

;; A LCString is a String that consists of lower-case letters.

;; A Token is one of:
;; - 1String
;; - LCString


;; Line -> [List-of Token]
;; Converts a line into a list of tokens.
(check-expect (tokenize '()) '())
(check-expect (tokenize '("a")) '("a"))
(check-expect (tokenize '(" ")) '())
(check-expect (tokenize '("\\")) '("\\"))
(check-expect (tokenize '("a" "\\" " ")) '("a\\"))
(check-expect (tokenize '("A")) '("A"))
(check-expect (tokenize '("A" "b" " " "C" "D" " " "E")) '("ab" "cd" "E"))
(check-expect (tokenize '("a" "b" " " "C" "D")) '("ab" "cd"))
(check-expect (tokenize '("a" "b" " " "c" "d" " ")) '("ab" "cd"))
(check-expect (tokenize '("a" "b" " " " " " " "c" "d" " ")) '("ab" "cd"))
(define (tokenize line)
  (cond
    [(empty? line) '()]
    [else
     (local ((define token (first-token line))
             (define tokenized (tokenize (remove-first-token line))))
       (if (string=? "" token)
           tokenized
           (cons (if (= 1 (string-length token))
                     token
                     (string-downcase token))
                 tokenized)))]))

;; Line -> [Token or ""]
;; Produces the first token on the given line.
(check-expect (first-token '()) "")
(check-expect (first-token '(" ")) "")
(check-expect (first-token '("a")) "a")
(check-expect (first-token '("A")) "A")
(check-expect (first-token '("a" "b")) "ab")
(check-expect (first-token '("A" "B")) "AB")
(check-expect (first-token '("a" "b" " ")) "ab")
(check-expect (first-token '("a" "b" " " " " "c" "d")) "ab")
(check-expect (first-token '("a" "b" "\\" " " "c" "d")) "ab\\")
(define (first-token line)
  (cond
    [(empty? line) ""]
    [(string-whitespace? (first line)) ""]
    [else (string-append (first line)
                         (first-token (rest line)))]))

;; Line -> Line
;; Produces the line the same as the given one
;; but without the first token.
(check-expect (remove-first-token '()) '())
(check-expect (remove-first-token '("a")) '())
(check-expect (remove-first-token '("a" "b")) '())
(check-expect (remove-first-token '("a" "b" " ")) '())
(check-expect (remove-first-token '("a" "b" " " " " "c" "d")) '("c" "d"))
(check-expect (remove-first-token '("A" "B" "\\" " " "c" "d")) '("c" "d"))
(check-expect (remove-first-token '("A" "B" " " "c" "d" "\\" " ")) '("c" "d" "\\" " "))
(define (remove-first-token line)
  (cond
    [(empty? line) '()]
    [(string-whitespace? (first line))
     (remove-leading-whitespaces (rest line))]
    [else (remove-first-token (rest line))]))

;; Line -> Line
;; Removes the leading whitespaces from the given line.
(check-expect (remove-leading-whitespaces '()) '())
(check-expect (remove-leading-whitespaces '("a")) '("a"))
(check-expect (remove-leading-whitespaces '(" " "a")) '("a"))
(check-expect (remove-leading-whitespaces '(" " " " "a" "b" " " "c"))
              '("a" "b" " " "c"))
(define (remove-leading-whitespaces line)
  (cond
    [(empty? line) '()]
    [(string-whitespace? (first line))
     (remove-leading-whitespaces (rest line))]
    [else line]))

