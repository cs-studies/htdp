;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-376) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 376.
;; Design a program that counts all "hello"s in an instance of XEnum.


(require 2htdp/abstraction)


;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))

;; A Body is a [List-of Xexpr].

;; An Xexpr is a list:
;; – (cons Symbol Body)
;; – (cons Symbol (cons [List-of Attribute] Body))

;; An Attrs-or-Xexpr is one of:
;; - [List-of Attribute]
;; - Xexpr

;; An XWord is '(word ((text String))).

;; An XItem is one of:
;; – (cons 'li (cons XWord '()))
;; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
;; – (cons 'li (cons XEnum '()))
;; – (cons 'li (cons [List-of Attribute] (cons XEnum '())))

;; An XEnum is one of:
;; – (cons 'ul [List-of XItem])
;; – (cons 'ul (cons [List-of Attribute] [List-of XItem]))


(define w1 '(word ((text "one"))))

(define w2 '(word ((text "hello"))))

(define w3 '(word ((text "three"))))

(define i1 `(li ,w1))

(define i2 `(li ,w2))

(define i3 `(li ((id "third")) ,w3))

(define e1 `(ul ,i1 ,i2))

(define e2 `(ul (li ,e1) ,i2 ,i3))

(define e3 `(ul ,i1 (li ,e1) (li ,e2)))


;; XEnum -> Number
;; Counts all "hello" in e.
(check-expect (count-enum e1) 1)
(check-expect (count-enum e2) 2)
(check-expect (count-enum e3) 3)
(define (count-enum e)
  (for/sum ([i (xexpr-content e)]) (count-item i)))

;; XItem -> Number
;; Counts all "hello" in i.
(check-expect (count-item i1) 0)
(check-expect (count-item i2) 1)
(check-expect (count-item `(li ,e1)) 1)
(check-expect (count-item `(li ,e2)) 2)
(define (count-item i)
  (local ((define content (first (xexpr-content i)))
          (define (word? v)
            (match v
              [(list 'word (list (list 'text (? string?)))) #true]
              [else #false]))
          (define (word-text w)
            (match w
              [(list 'word (list (list 'text txt))) txt])))
    (cond
      [(word? content)
       (if (string=? "hello" (word-text content)) 1 0)]
      [else (count-enum content)])))

;; Xexpr -> Body
;; Retrieves the list of content elements.
(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe))
          (define (list-of-attributes? x)
            (cond
              [(empty? x) #true]
              [else
               (local ((define possible-attribute (first x)))
                 (cons? possible-attribute))])))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (if (list-of-attributes? (first optional-loa+content))
           (rest optional-loa+content)
           optional-loa+content)])))

