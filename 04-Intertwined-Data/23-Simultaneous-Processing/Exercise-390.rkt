;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-390) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 390.
;; Design the function tree-pick.
;; The function consumes a tree of symbols and a list of directions.


(define-struct branch [left right])

;; A TOS (short for Tree of Symbols) is one of:
;; - Symbol
;; - (make-branch TOS TOS)

;; A Direction is one of:
;; - 'left
;; - 'right

;; A Path is a [List-of Direction].


;; TOS Path -> TOS
;; Produces TOS found at the given path in the t.
;; Signals an error when given a symbol and non-empty path.
(check-expect (tree-pick 'a '()) 'a)
(check-expect (tree-pick (make-branch 'a 'b) '()) (make-branch 'a 'b))
(check-error (tree-pick 'a '(left)) "path too long")
(check-expect (tree-pick (make-branch 'a 'b) '(left)) 'a)
(check-expect (tree-pick (make-branch 'a 'b) '(right)) 'b)
(check-expect (tree-pick (make-branch 'a (make-branch 'b 'c)) '(right))
              (make-branch 'b 'c))
(check-expect (tree-pick (make-branch 'a (make-branch 'b 'c)) '(left)) 'a)
(check-expect (tree-pick (make-branch 'a (make-branch 'b 'c)) '(right left)) 'b)
(define (tree-pick tree lod)
  (cond
    [(and (symbol? tree) (empty? lod)) tree]
    [(and (branch? tree) (empty? lod)) tree]
    [(and (symbol? tree) (cons? lod)) (error "path too long")]
    [(and (branch? tree) (cons? lod))
     (tree-pick
      (if (symbol=? 'left (first lod))
          (branch-left tree)
          (branch-right tree))
      (rest lod))]))

