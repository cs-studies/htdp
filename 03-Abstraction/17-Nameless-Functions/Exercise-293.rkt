;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-293) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 293.
;; Develop found?, a specification for the find function.
;; Use found? to formulate a check-satisfied test for find.


;; X [List-of X] -> [Maybe [List-of X]]
;; Returns the first sublist of l that starts
;; with x, #false otherwise.
(check-expect (find "a" '()) #false)
(check-expect (find "a" '("b" "c" "d")) #false)
(check-expect (find "a" '("a")) '("a"))
(check-expect (find "b" '("a" "b" "c")) '("b" "c"))
(check-satisfied (find "a" '()) (found? "a" '()))
(check-satisfied (find "a" '("b" "c" "d")) (found? "a" '("b" "c" "d")))
(check-satisfied (find "a" '("a")) (found? "a" '("a")))
(check-satisfied (find "b" '("a" "b" "c")) (found? "b" '("a" "b" "c")))
(define (find x l)
  (cond
    [(empty? l) #false]
    [else
     (if (equal? (first l) x) l (find x (rest l)))]))

;; X [List-of X] -> [ [Maybe [List-of X]] -> Boolean ]
;; Determines whether ml is either false or a sublist of l.
(define (found? x l)
  (lambda (ml)
    (local (;; X [List-of X] -> Boolean
            (define (not-on-list? x l)
              (and (false? ml) (not (member? x l))))

            ;; [List-of X] [List-of X] -> Boolean
            (define (is-sublist? subl l)
              (local (;; [List-of X] [List-of X] -> Boolean
                      ;; Are all items on list l2 members of the list l1.
                      (define (contains? l1 l2)
                        (andmap (lambda (l2-x) (member? l2-x l1)) l2)))
                (and (list? subl)
                     (>= (length l) (length subl))
                     (contains? l subl)))))
      (or (not-on-list? x l) (is-sublist? ml l)))))

