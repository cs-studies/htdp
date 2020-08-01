;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-372) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 372.
;; Equip the definition of render-item1 with tests.
;; Make sure to formulate these tests in such a way
;; that they don’t depend on the BT constant.
;; Then explain how the function works;
;; keep in mind that the purpose statement explains what it does.


(require 2htdp/image)
(require 2htdp/abstraction)


;;; Data Definitions

;; An Attribute is a list of two items:
;;   (cons Symbol (cons String '()))

;; A Body is a [List-of Xexpr].

;; An Xexpr is a list:
;; – (cons Symbol Body)
;; – (cons Symbol (cons [List-of Attribute] Body))

;; An XWord is '(word ((text String))).

;; An XItem is one of:
;; – (cons 'li (cons XWord '()))
;; – (cons 'li (cons [List-of Attribute] (cons XWord '())))

;; An XEnum is one of:
;; – (cons 'ul [List-of XItem])
;; – (cons 'ul (cons [List-of Attribute] [List-of XItem]))


;;; Constants

(define BT (overlay (circle 2 "solid" 'black) (circle 3 "solid" 'white)))

(define w1
  '(word ((text "one"))))

(define w2
  '(word ((text "two"))))

(define i1 `(li ,w1))

(define i2 `(li ,w2))


;;; Functions

;; XItem -> Image
;; Renders an item as a "word" prefixed by a bullet.
(check-expect (render-item `(li ,w1))
              (beside/align 'center BT (text "one" 12 'black)))
(check-expect (render-item `(li ,w2))
              (beside/align 'center BT (text "two" 12 'black)))
(check-expect (render-item `(li ((id "second")) ,w2))
              (beside/align 'center BT (text "two" 12 'black)))
(define (render-item i)
  (local (;; Xexpr -> Body
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
          ;; XWord -> String
          (define (word-text w)
            (match w
              [(list 'word (list (list 'text txt))) txt]))

          (define content (xexpr-content i))
          (define element (first content))
          (define a-word (word-text element))
          (define item (text a-word 12 'black)))
    (beside/align 'center BT item)))


;;; Answer.
;; The function parses XWord String contents from a given XItem list
;; and produces an image containing the parsed string,
;; prepended with a configured bullet (small black circle).

