;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-189) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 189.
;; Develop the function search-sorted,
;; which determines whether a number occurs in a sorted list of numbers.
;; The function must take advantage of the fact that the list is sorted.


;; Number List-of-numbers -> Boolean
;; Determines whether a number occurs in a sorted list of numbers.
(check-expect (search-sorted 5 '()) #false)
(check-expect (search-sorted 5 (list 2)) #false)
(check-expect (search-sorted 5 (list 5)) #true)
(check-expect (search-sorted 5 (list 2 1)) #false)
(check-expect (search-sorted 5 (list 6 4)) #false)
(check-expect (search-sorted 5 (list 5 2 1)) #true)
(check-expect (search-sorted 5 (list 10 5 2)) #true)
(check-expect (search-sorted 5 (list 20 10 5)) #true)
(define (search-sorted n l)
  (cond
    [(empty? l) #false]
    [else (if (> n (first l))
              #false
              (or (= n (first l))
                  (search-sorted n (rest l))))]))


;;; Application

;(search-sorted 5 (list 20 10 5))

;(search-sorted 5 (list 6 4))

