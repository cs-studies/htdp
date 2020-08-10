;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-384) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 384.
;; Formulate the missing pieces
;; - the interpretation of data and purpose statements -
;; for all the locally defined functions.


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

(define-struct data [price delta])
;; A StockWorld is a structure: (make-data String String)
;; (make-data p d) represents a price p
;; and price change d.


(define BASE-URL "https://www.marketwatch.com/investing/stock/")
(define COMPANY "f")
(define SIZE 22) ; font size


;; String -> StockWorld
;; Retrieves the stock price of co and its change every 15s.
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
      [on-tick retrieve-stock-data 15]
      [to-draw render-stock-data])))

;; Xexpr String -> String
;; Retrieves the value of the "content" attribute
;; from a 'meta element that has attribute "itemprop"
;; with value s.
(define (get x s) "a")


;;; Application

;(stock-alert "f") ; Ford

