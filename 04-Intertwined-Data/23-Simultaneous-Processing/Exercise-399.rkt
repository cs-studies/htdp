;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-399) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 399.
;; Design two auxiliary functions: random-pick and non-same.


;; [List-of String] -> [List-of String]
;; Picks a random non-identity arrangement of names.
(define (gift-pick names)
  (random-pick
   (non-same names (arrangements names))))

;; [List-of String] -> [List-of [List-of String]]
;; Returns all possible permutations of names.
;; See exercise 213.
(check-expect (arrangements '()) (list '()))
(check-expect (arrangements '("kim")) '(("kim")))
(check-expect (arrangements '("bob" "kim")) '(("bob" "kim") ("kim" "bob")))
(check-expect (arrangements '("am" "bob" "kim"))
              '(("am" "bob" "kim")
                ("bob" "am" "kim")
                ("bob" "kim" "am")
                ("am" "kim" "bob")
                ("kim" "am" "bob")
                ("kim" "bob" "am")))
(define (arrangements names)
  (cond
    [(empty? names) (list '())]
    [else
     (local (;; String [List-of [List-of String]] -> [List-of [List-of String]]
             (define (insert-everywhere/in-all-words name low)
               (cond
                 [(empty? low) '()]
                 [else (append (insert-everywhere name '() (first low))
                               (insert-everywhere/in-all-words name (rest low)))]))
             ;; String [List-of String] [List-of String] -> [List-of [List-of String]]
             (define (insert-everywhere name prefix suffix)
               (cond
                 [(empty? suffix)
                  (list (append prefix (list name)))]
                 [else
                  (append
                   (list (append prefix (list name) suffix))
                   (insert-everywhere
                    name
                    (append prefix (list (first suffix)))
                    (rest suffix)))])))

       (insert-everywhere/in-all-words (first names)
                                       (arrangements (rest names))))]))

;; [NEList-of X] -> X
;; Returns a random item from the list.
(check-random (random-pick '(0 1 2 3)) (random 4))
(check-random (random-pick '("am" "bob" "kim"))
              (list-ref '("am" "bob" "kim") (random 3)))
(define (random-pick l)
  (list-ref l (random (length l))))

;; [List-of String] [List-of [List-of String]] -> [List-of [List-of String]]
;; Produces the list of those lists in ll
;; that do not agree with names at any place.
(check-expect (non-same '() '()) '())
(check-expect (non-same '("am") '(("am"))) '())
(check-expect (non-same '("am") '(("bob"))) '(("bob")))
(check-expect (non-same '("am" "bob") '(("am" "bob") ("bob" "am"))) '(("bob" "am")))
(check-expect (non-same '("am" "bob" "kim") '(("am" "bob" "kim")
                                              ("am" "kim" "bob")
                                              ("bob" "am" "kim")
                                              ("bob" "kim" "am")
                                              ("kim" "am" "bob")
                                              ("kim" "bob" "am")))
              '(("bob" "kim" "am") ("kim" "am" "bob")))
(define (non-same names ll)
  (cond
    [(empty? ll) '()]
    [else
     (local ((define (non-same? names l)
               (cond
                 [(empty? l) #true]
                 [else (or (string=? (first names) (first l))
                           (non-same? (rest names) (rest l)))])))
       (append
        (if (non-same? names (first ll))
            (list (first ll))
            '())
        (non-same names (rest ll))))]))


;;; Application

(gift-pick '("Louise" "Jane" "Laura" "Dana" "Mary"))

