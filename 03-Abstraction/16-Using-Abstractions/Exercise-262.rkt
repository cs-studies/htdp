;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-262) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 262.
;; Design the function identityM, which creates diagonal squares of 0s and 1s.
;; Use the structural design recipe and exploit the power of local.


;; A Row is a list of strictly one 1 and zero or more 0s.

;; Number -> [List-of Row]
;; Produces an identity matrix of the size n.
(check-expect (identityM 1) (list (list 1)))
(check-expect (identityM 2) (list (list 1 0) (list 0 1)))
(check-expect (identityM 3) (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))
(define (identityM size0)
  (local (
          ;; Number Number -> [List-of Row]
          (define (build-matrix size 1-pos)
            (cond
              [(> 1-pos size) '()]
              [else
               (cons
                (build-row size 1-pos 1)
                (build-matrix size (add1 1-pos)))]))

          ;; Number Number Number -> Row
          (define (build-row size 1-pos current)
            (cond
              [(> current size) '()]
              [else (cons
                     (if (= current 1-pos) 1 0)
                     (build-row size 1-pos (add1 current)))])))
    (build-matrix size0 1)))


;;; Application

;(identityM 10)

