;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-136) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 136.
;; Validate with DrRacket’s stepper:
;; (our-first (our-cons "a" '())) == "a"
;; (our-rest (our-cons "a" '())) == '()


(define-struct pair [left right])
; A ConsPair is a structure:
;   (make-pair Any Any).

; A ConsOrEmpty is one of:
; – '()
; – (make-pair Any ConsOrEmpty)
; interpretation ConsOrEmpty is the class of all lists

; Any Any -> ConsOrEmpty
(define (our-cons a-value a-list)
  (cond
    [(or (empty? a-list) (pair? a-list)) (make-pair a-value a-list)]
    [else (error "cons: second argument ...")]))

; ConsOrEmpty -> Any
; extracts the left part of the given pair
(define (our-first a-list)
  (if (empty? a-list)
      (error 'our-first "...")
      (pair-left a-list)))


; ConsOrEmpty -> Any
; extracts the right part of the given pair
(define (our-rest a-list)
  (if (empty? a-list)
      a-list
      (pair-right a-list)))


;(our-first (our-cons "a" '()))

;(our-rest (our-cons "a" '()))

