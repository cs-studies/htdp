;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-377) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 377.
;; Design a program that replaces all "hello"s with "bye" in an enumeration.


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
(define w2-replaced '(word ((text "bye"))))

(define w3 '(word ((text "three"))))

(define i1 `(li ,w1))

(define i2 `(li ,w2))
(define i2-replaced `(li ,w2-replaced))

(define i3 `(li ((id "third")) ,w3))

(define e1 `(ul ,i1 ,i2))
(define e1-replaced `(ul ,i1 (li ,w2-replaced)))

(define e2 `(ul (li ,e1) ,i2 ,i3))
(define e2-replaced `(ul (li ,e1-replaced) ,i2-replaced ,i3))

(define e3 `(ul ,i1 (li ,e1) (li ,e2)))
(define e3-replaced `(ul ,i1 (li ,e1-replaced) (li ,e2-replaced)))


;; Symbol [List-of Attribute] Body -> Xexpr
;; Builds an Xexpr for the given parts.
(check-expect (build-xexpr 'li '() w1) (list 'li w1))
(check-expect (build-xexpr 'li '((id "test")) w2) `(li ((id "test")) ,w2))
(define (build-xexpr name attrs body)
  (if (empty? attrs)
      (list name body)
      (list name attrs body)))

;; XEnum -> Number
;; Replaces all "hello" with "bye" in e.
(check-expect (replace-enum e1) e1-replaced)
(check-expect (replace-enum e2) e2-replaced)
(check-expect (replace-enum e3) e3-replaced)
(define (replace-enum e)
  (local ((define replaced-content
            (for/list ([i (xexpr-content e)]) (replace-item i)))
          (define attrs (xexpr-attr e))
          (define body (if (empty? attrs)
                           replaced-content
                           (cons attrs replaced-content))))
    (cons (xexpr-name e) body)))


;; XItem -> Number
;; Replaces all "hello" with "bye" in i.
(check-expect (replace-item i1) i1)
(check-expect (replace-item i2) `(li ,w2-replaced))
(check-expect (replace-item `(li ,e1)) `(li ,e1-replaced))
(check-expect (replace-item `(li ,e2)) `(li ,e2-replaced))
(define (replace-item i)
  (local ((define content (first (xexpr-content i)))
          (define (word? v)
            (match v
              [(list 'word (list (list 'text (? string?)))) #true]
              [else #false]))
          (define (word-text w)
            (match w
              [(list 'word (list (list 'text txt))) txt])))
    (build-xexpr
     (xexpr-name i)
     (xexpr-attr i)
     (cond
       [(word? content)
        (if (string=? "hello" (word-text content))
            '(word ((text "bye")))
            content)]
       [else (replace-enum content)]))))

;; Xexpr -> [List-of Attribute]
;; Retrieves the list of attributes of xe.
(define (xexpr-attr xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (local ((define loa-or-x
                 (first optional-loa+content)))
         (if (list-of-attributes? loa-or-x)
             loa-or-x
             '()))])))

;; Attrs-or-Xexpr -> Boolean
;; Determines whether x is an element of [List-of Attribute].
;; Otherwise produces #false.
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]
    [else
     (local ((define possible-attribute (first x)))
       (cons? possible-attribute))]))

;; Xexpr -> Symbol
;; Retrieves the tag of the element representation.
(define (xexpr-name xe)
  (first xe))

;; Xexpr -> [List-of Xexpr]
;; Retrieves the list of content elements.
(define (xexpr-content xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()]
      [else
       (if (list-of-attributes? (first optional-loa+content))
           (rest optional-loa+content)
           optional-loa+content)])))

