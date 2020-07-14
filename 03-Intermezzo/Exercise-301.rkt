;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-301) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 301.


(define (insertion-sort alon)
;----------------------------------------------------------
  (local ((define (sort alon)
            ;;------------------------------------------
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (sort (rest alon)))])
            ;;------------------------------------------
            )
          (define (add an alon)
            ;;;-----------------------------------------
            (cond
              [(empty? alon) (list an)]
              [else
               (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon)
                             (add an (rest alon)))])])
            ;;;-----------------------------------------
          ))
    (sort alon)))
;----------------------------------------------------------



(define (sort2 alon)
;----------------------------------------------------------
  (local ((define (sort2 alon)
            ;;------------------------------------------
            (cond
              [(empty? alon) '()]
              [else
               (add (first alon) (sort2 (rest alon)))])
            ;;------------------------------------------
            )
          (define (add an alon)
            ;;------------------------------------------
            (cond
              [(empty? alon) (list an)]
              [else
                (cond
                  [(> an (first alon)) (cons an alon)]
                  [else (cons (first alon)
                              (add an (rest alon)))])])
            ;;-------------------------------------------
            ))
    (sort2 alon)))
;-----------------------------------------------------------


(define list-1 '(5 28 31 69 86 26 4 2 100))

(check-expect (insertion-sort list-1) (sort2 list-1))


;;; Answer.
;; No.
;; The only minor difference is the outer sort2
;; is masked (name masking) by the local sort2,
;; the same time insertion-sort
;; is a unique function name in the given context.

