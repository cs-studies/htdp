;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-386) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 386.
;; Formulate test cases for the get function,
;; that look for other values than "F"
;; and that force get to signal an error.
;; Design get-xexpr.
;; Derive functional examples for this function from those for get.
;; Generalize these examples
;; so that you are confident get-xexpr
;; can traverse an arbitrary Xexpr.
;; Finally, formulate a test that uses the web data saved in exercise 385.


(require 2htdp/batch-io)
(require 2htdp/universe)
(require 2htdp/image)


;; An Attribute is a list of two items:
;;    (list Symbol String)

;; An Attribute* is a [List-of Attribute]

;; An Xexpr is one of:
;; - Symbol
;; - String
;; - Number
;; - (cons Symbol (cons Attribute* [List-of Xexpr]))
;; - (cons Symbol [List-of Xexpr])

;; An Attrs-or-Xexpr is one of:
;; - Attribute*
;; - Xexpr


(define-struct data [price delta])
;; A StockWorld is a structure: (make-data String String)
;; (make-data p d) represents a price p
;; and price change d.


(define BASE-URL "https://www.marketwatch.com/investing/stock/")
(define COMPANY "f")
(define SIZE 22) ; font size

(define machine-test
  '(machine ((initial "red"))
            (action ((state "red") (next "green")))
            (action ((content "Read It!") (name "Inner"))
                    10
                    "green"
                    (meta ((content "yellow") (name "color"))))
            (action ((state "yellow") (next "red")))))

(define html-test
  (read-xexpr "./files/ford.html"))


;; String -> StockWorld
;; Retrieves the stock price of co and its change every 30s.
(define (stock-alert co)
  (local ((define url (string-append BASE-URL co))
          ;; [StockWorld -> StockWorld]
          (define (retrieve-stock-data __w)
            (local ((define x (read-xexpr/web url)))
              (make-data (get x "price")
                         (get x "priceChange"))))
          ;; StockWorld -> Image
          (define (render-stock-data w)
            (local (;; [StockWorld -> String] -> Image
                    (define (word sel col)
                      (text (sel w) SIZE col)))
              (overlay (beside (word data-price 'black)
                               (text "  " SIZE 'white)
                               (word data-delta 'red))
                       (rectangle 300 35 'solid 'white)))))
    (big-bang (retrieve-stock-data 'no-use)
      [on-tick retrieve-stock-data 30]
      [to-draw render-stock-data])))

;; Xexpr String -> String
;; Retrieves the value of the "content" attribute
;; from a 'meta element that has attribute "name"
;; with value s.
;; Otherwise produces error.
(check-expect (get '(meta ((content "+1") (name "F"))) "F") "+1")
(check-expect (get '(meta ((content "it") (name "is"))) "is") "it")
(check-expect (get machine-test "color") "yellow")
(check-error (get '(meta ((content "+1") (name "F"))) "C") "not found")
(check-error (get machine-test "Inner") "not found")
(check-error (get 'F "F") "not found")
(define (get x s)
  (local ((define result (get-xexpr x s)))
    (if (string? result)
        result
        (error "not found"))))

;; Xexpr String -> [Maybe String]
;; Retrieves the value of the "content" attribute
;; from a 'meta element that has attribute "name"
;; with value s.
;; Otherwise produces #false.
(check-expect (get-xexpr 'F "F") #false)
(check-expect (get-xexpr "F" "F") #false)
(check-expect (get-xexpr 4 "F") #false)
(check-expect (get-xexpr '(meta ((content "+1") (name "F"))) "F") "+1")
(check-expect (get-xexpr '(meta ((content "+1") (name "F"))) "C") #false)
(check-expect (get-xexpr machine-test "Inner") #false)
(check-expect (get-xexpr machine-test "Absent") #false)
(check-expect (get-xexpr html-test "exchangeIso") "XNYS")
(check-expect (get-xexpr html-test "notthere") #false)
(define (get-xexpr x s)
  (cond
    [(or (not (list? x)) (empty? x)) #false]
    [else
     (local ((define name (xexpr-name x))
             (define attrs (xexpr-attr x))
             (define content (xexpr-content x))
             (define (find-attr loa s)
               (local ((define found (assq s loa)))
                 (if (false? found)
                     #false
                     (second found))))
             (define attr-name-val (find-attr attrs 'name))
             (define attr-content-val (find-attr attrs 'content))
             (define (get-xexpr* l s)
               (cond
                 [(empty? l) #false]
                 [else (local ((define found (get-xexpr (first l) s)))
                         (if (false? found) (get-xexpr* (rest l) s) found))])))
       (if (and (symbol=? name 'meta)
                (not (false? attr-name-val))
                (string=? attr-name-val s)
                (not (false? attr-content-val)))
           attr-content-val
           (get-xexpr* content s)))]))

;; Xexpr -> Symbol
;; Retrieves the tag of the element representation.
(define (xexpr-name xe)
  (first xe))

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


;;; Application

;; Too many requests will be blocked by the site.
;; Check if the requests are blocked with
;; (read-xexpr/web (string-append BASE-URL "f"))
;; Optionally, parse html-test instead.

;(stock-alert "f") ; Ford

