;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-478) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 478.
;; Explain why all of these solutions
;; are just like the three scenarios depicted in figure 173.
;; This leaves the central square.
;; Is it possible to place even a second queen
;; after you place one on the central square of a 3 by 3 board?


;; The boards are symmetric n x n spaces with no rules over positioning directions.
;; The "threatening rules" are bound to the board's axis only.
;; When a board is rotated strictly 90 degrees, the axis and rules match the previous position.
;; Hence a situation on a board repeats itself with such a rotation.
;; Thus the scenarios are the same having the queen positioned
;; in all the squares of the marginal rows and columns.

;; A queen positioned on the central square threatens all remaining squares of the 3 x 3 board.
;; So it is not possible no place the second queen in this case.

