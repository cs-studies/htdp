;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-355) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 355.
;; Design eval-var-lookup.
;; The function traverses the expression in the manner
;; that the design recipe for BSL-var-expr suggests.
;; As it descends the expression, it "carries along" da.
;; When it encounters a symbol x,
;; it uses assq to look up the value of x in the association list.
;; If there is no value, eval-var-lookup signals an error.


(define-struct add [left right])

(define-struct mul [left right])

;; A BSL-var-expr is one of:
;; – Number
;; – Symbol
;; – (make-add BSL-var-expr BSL-var-expr)
;; – (make-mul BSL-var-expr BSL-var-expr)

;; A BSL-expr is one of:
;; – Number
;; – (make-add BSL-expr BSL-expr)
;; – (make-mul BSL-expr BSL-expr)

;; A BSL-value is a Number.

;; An Association is a list of two items:
;;   (cons Symbol (cons Number '())).
(define a-1 (cons 'x (cons 3 '())))
(define a-2 (cons 'y (cons 5 '())))

;; An AL (short for association list) is [List-of Association].
(define al (list a-1 a-2))

(define NO-VALUE "Symbol value must be provided.")


;; BSL-var-expr AL -> BSL-value
;; Determines value of ex.
;; If required Association is not on the association list,
;; produces NO-VALUE error.
(check-expect (eval-var-lookup 100 '()) 100)
(check-expect (eval-var-lookup 100 al) 100)
(check-error (eval-var-lookup 'x '()) NO-VALUE)
(check-expect (eval-var-lookup 'x al) 3)
(check-error (eval-var-lookup 'z al) NO-VALUE)
(check-expect (eval-var-lookup (make-add 5 3) '()) 8)
(check-expect (eval-var-lookup (make-add 5 3) al) 8)
(check-expect (eval-var-lookup (make-add 'x 3) al) 6)
(check-error (eval-var-lookup (make-add 'z 3) al) NO-VALUE)
(check-expect (eval-var-lookup (make-mul 1/2 (make-mul 'y 4)) al) 10)
(check-error (eval-var-lookup (make-mul 1/2 (make-mul 'z 3)) al) NO-VALUE)
(check-expect (eval-var-lookup (make-add (make-mul 'x 'x) (make-add 'y 'y)) al) 19)  
(check-error (eval-var-lookup (make-add (make-mul 'x 'x) (make-add 'z 'z)) al)
             NO-VALUE)
(define (eval-var-lookup ex l)
  (local (;; Symbol -> Number
          (define (find-value s)
            (local ((define symbol-assoc (assq ex l)))
              (if (false? symbol-assoc)
                  (error NO-VALUE)
                  (second symbol-assoc)))))
    (cond
      [(number? ex) ex]
      [(symbol? ex) (find-value ex)]
      [(add? ex)
       (+ (eval-var-lookup (add-left ex) l)
          (eval-var-lookup (add-right ex) l))]
      [(mul? ex)
       (* (eval-var-lookup (mul-left ex) l)
          (eval-var-lookup (mul-right ex) l))])))

