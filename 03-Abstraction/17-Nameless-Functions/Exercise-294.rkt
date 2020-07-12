;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-294) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 294.
;; Develop is-index?, a specification for index.
;; Use is-index? to formulate a check-satisfied test for index.


;; X [List-of X] -> [Maybe N]
;; Determine the index of the first occurrence
;; of x in l, #false otherwise.
(check-expect (index 10 '()) #false)
(check-expect (index 10 '(1 2 3)) #false)
(check-expect (index 10 '(10 20 30)) 0)
(check-expect (index 10 '(20 10 10)) 1)
(check-expect (index 10 '(20 30 10)) 2)
(check-satisfied (index 10 '()) (is-index? 10 '()))
(check-satisfied (index 10 '(1 2 3)) (is-index? 10 '(1 2 3)))
(check-satisfied (index 10 '(10 20 30)) (is-index? 10 '(10 20 30)))
(check-satisfied (index 10 '(20 30 10)) (is-index? 10 '(20 30 10)))
(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))

;; X [List-of X] -> [ [Maybe N] -> Boolean ]
;; Creates a specification function for index.
(define (is-index? x l)
  (lambda (i)
    (local (;; X [List-of X] -> Boolean
            (define (not-found? x l)
              (and (false? i) (not (member? x l))))

            ;; N [List-of X] -> Boolean
            (define (is-valid? i l)
              (and
               (< i (length l))
               (eq? (list-ref l i) x)
               (not (member? x (build-list i (lambda (j) (list-ref l j))))))))
      (or (not-found? x l) (is-valid? i l)))))

