;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-490) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 490.
;; Develop a formula that describes the abstract running time of relative->absolute.


;; [List-of Number] -> [List-of Number]
;; Converts a list of relative to absolute distances.
;; the first number represents the distance to the origin.
(check-expect (relative->absolute '(30)) '(30))
(check-expect (relative->absolute '(40 30)) '(40 70))
(check-expect (relative->absolute '(50 40 70 30 30)) '(50 90 160 190 220))
(define (relative->absolute l)
  (cond
    [(empty? l) '()]
    [else (local ((define n (first l)))
            (cons n (add-to-each n (relative->absolute (rest l)))))]))

(define (add-to-each n l)
  (cond
    [(empty? l) '()]
    [else (cons (+ (first l) n) (add-to-each n (rest l)))]))


;;; Answer
;; Let n denote a size of the given list.
;; Then the formula that describes
;; the abstract running time of relative->absolute is
;; n + n + (n - 1) * n / 2
;; and the function's performance is O(n^2).


;(define size 1)
;(relative->absolute (build-list size add1))

(relative->absolute (build-list 1 add1))
; 1 recursive call to relative->absolute
; 1 call to add-to-each
;=
(relative->absolute '(1))
;=
(cons 1 (add-to-each 1 (relative->absolute '())))
;=
(cons 1 (add-to-each 1 '()))
;=
(cons 1 '())


(relative->absolute (build-list 2 add1))
; 2 recursive calls to relative->absolute
; 2 + 1 calls to add-to-each
;=
(relative->absolute '(1 2))
;=
(cons 1 (add-to-each 1 (relative->absolute '(2))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (relative->absolute '())))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 '()))))
;=
(cons 1 (add-to-each 1 (cons 2 '())))
;=
(cons 1 (cons (+ 2 1) (add-to-each 2 '())))
;=
(cons 1 (cons 3 '()))


(relative->absolute (build-list 3 add1))
; 3 recursive calls to relative->absolute
; 3 + 3 calls to add-to-each
;=
(relative->absolute '(1 2 3))
;=
(cons 1 (add-to-each 1 (relative->absolute '(2 3))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (relative->absolute '(3))))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (cons 3 (add-to-each 3 (relative->absolute '())))))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (cons 3 (add-to-each 3 '()))))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (cons 3 '())))))
;=
(cons 1 (add-to-each 1 (cons 2 (cons (+ 3 2) (add-to-each 2 '())))))
;=
(cons 1 (add-to-each 1 (cons 2 (cons 5 '()))))
;=
(cons 1 (cons (+ 2 1) (add-to-each 1 (cons 5 '()))))
;=
(cons 1 (cons 3 (cons (+ 5 1) (add-to-each 1 '()))))
;=
(cons 1 (cons 3 (cons 6 '())))


(relative->absolute (build-list 4 add1))
; 4 recursive calls to relative->absolute
; 4 + 6 calls to add-to-each
;=
(relative->absolute '(1 2 3 4))
;=
(cons 1 (add-to-each 1 (relative->absolute '(2 3 4))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (relative->absolute '(3 4))))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (cons 3 (add-to-each 3 (relative->absolute '(4))))))))
;=
(cons
 1
 (add-to-each 1
              (cons 2
                    (add-to-each 2
                                 (cons 3
                                       (add-to-each 3
                                                    (cons 4
                                                          (add-to-each 4
                                                                       (relative->absolute
                                                                        '())))))))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (cons 3 (add-to-each 3 (cons 4 (add-to-each 4
                                                                                          '()))))))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (cons 3 (add-to-each 3 (cons 4 '())))))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (cons 3 (cons (+ 4 3) (add-to-each 3 '())))))))
;=
(cons 1 (add-to-each 1 (cons 2 (add-to-each 2 (cons 3 (cons 7 '()))))))
;=
(cons 1 (add-to-each 1 (cons 2 (cons (+ 3 2) (add-to-each 2 (cons 7 '()))))))
;=
(cons 1 (add-to-each 1 (cons 2 (cons 5 (cons (+ 7 2) (add-to-each 2 '()))))))
;=
(cons 1 (add-to-each 1 (cons 2 (cons 5 (cons 9 '())))))
;=
(cons 1 (cons (+ 2 1) (add-to-each 1 (cons 5 (cons 9 '())))))
;=
(cons 1 (cons 3 (cons (+ 5 1) (add-to-each 1 (cons 9 '())))))
;=
(cons 1 (cons 3 (cons 6 (cons (+ 9 1) (add-to-each 1 '())))))
;=
(cons 1 (cons 3 (cons 6 (cons 10 '()))))

