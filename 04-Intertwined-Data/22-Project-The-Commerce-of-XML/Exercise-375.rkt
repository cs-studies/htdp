;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-375) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 375.
;; The wrapping of cond with
;; (beside/align 'center BT ...)
;; may surprise you.
;; Edit the function definition
;; so that the wrap-around appears once in each clause.
;; Why are you confident that your change works?
;; Which version do you prefer?


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
;; – (cons 'li (cons [List-of Attribute] (list XWord)))
;; – (cons 'li (cons XEnum '()))
;; – (cons 'li (cons [List-of Attribute] (list XEnum)))

;; An XEnum is one of:
;; – (cons 'ul [List-of XItem])
;; – (cons 'ul (cons [List-of Attribute] [List-of XItem]))


;;; Constants

(define FONT-SIZE 12)
(define FONT-COLOR 'black)
(define BT
  (beside
   (circle 2 "solid" "black")
   (text " " FONT-SIZE FONT-COLOR)))

(define w1
  '(word ((text "one"))))

(define w2
  '(word ((text "two"))))

(define w3
  '(word ((text "three"))))

(define i1 `(li ,w1))

(define i2 `(li ,w2))

(define i3 `(li ((id "third")) ,w3))

(define e1
  `(ul ,i1 ,i2))

(define e1-rendered
  (above/align
   'left
   (beside/align 'center BT (text "one" FONT-SIZE FONT-COLOR))
   (beside/align 'center BT (text "two" FONT-SIZE FONT-COLOR))))
;(place-image e1-rendered 20 20 (empty-scene 50 40 "white"))

(define e2
  `(ul ,i1 ,i2 ,i3))

(define e2-rendered
  (above/align
   'left
   (beside/align 'center BT (text "one" FONT-SIZE FONT-COLOR))
   (beside/align 'center BT (text "two" FONT-SIZE FONT-COLOR))
   (beside/align 'center BT (text "three" FONT-SIZE FONT-COLOR))))
;(place-image e2-rendered 30 30 (empty-scene 60 60 "white"))


(define e3
  `(ul ,i3 (li ,e1)))

(define e3-rendered
  (above/align
   'left
   (beside/align 'center BT (text "three" FONT-SIZE FONT-COLOR))
   (beside/align 'center BT
                 (above/align
                  'left
                  (beside/align 'center BT (text "one" FONT-SIZE FONT-COLOR))
                  (beside/align 'center BT (text "two" FONT-SIZE FONT-COLOR))))))
;(place-image e3-rendered 30 30 (empty-scene 60 60 "white"))


;;; Functions

;; XEnum -> Image
;; Renders a simple enumeration as an image.
(check-expect (render-enum e1) e1-rendered)
(check-expect (render-enum e2) e2-rendered)
(check-expect (render-enum e3) e3-rendered)
(define (render-enum xe)
  (local ((define content (xexpr-content xe))
          ;; XItem Image -> Image
          (define (deal-with-one item so-far)
            (above/align 'left (render-item item) so-far)))
    (foldr deal-with-one empty-image content)))

;; XItem -> Image
;; Renders an item as a "word" prefixed by a bullet.
(check-expect (render-item i1)
              (beside/align 'center BT (text "one" 12 'black)))
(check-expect (render-item i2)
              (beside/align 'center BT (text "two" 12 'black)))
(check-expect (render-item `(li ((id "second")) ,w2))
              (beside/align 'center BT (text "two" 12 'black)))
(define (render-item i)
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
        (beside/align 'center BT (text (word-text content) FONT-SIZE FONT-COLOR))]
       [else
        (beside/align 'center BT (render-enum content))])))

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


;;; Answer.
;; 1. The execution logic is correct, the tests pass.
;; This confirms the change works correctly.
;; 2. According to the abstraction principle (or DRY principle),
;; the first version - using function bulletize - is better,
;; since it abstracts over the code repetition.

