;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-516) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 516.
;; Redesign the undeclareds function
;; for the structure-based data representation from exercise 513.


;; A Lam is one of:
;; – Symbol
;; - LExpr
;; - LApp

(define-struct lexpr [param body])
;; A LExpr is a structure:
;;  (make-struct (list Symbol) Lam)

(define-struct lapp [fun arg])
;; A LApp is a structure:
;;  (make-struct Lam Lam)

(define ex1 (make-lexpr '(x) 'x))
(define ex2 (make-lexpr '(x) 'y))
(define ex3 (make-lexpr '(y) (make-lexpr '(x) 'y)))
(define ex4 (make-lapp (make-lexpr '(y) 'x) (make-lexpr '(x) 'x)))


;; Lam -> Lam
;; Replaces all symbols s in le with '*undeclared
;; if they do not occur within the body of a λ
;; expression whose parameter is s.
(check-expect (undeclareds ex1) (make-lexpr '(x) '*declared:x))
(check-expect (undeclareds ex2) (make-lexpr '(x) '*undeclared:y))
(check-expect (undeclareds ex3) (make-lexpr '(y) (make-lexpr '(x) '*declared:y)))
(check-expect (undeclareds ex4) (make-lapp (make-lexpr '(y) '*undeclared:x)
                                           (make-lexpr '(x) '*declared:x)))
(define (undeclareds le0)
  (local (
          ;; String Symbol -> String
          (define (build-name pref s)
            (string->symbol (string-append "*" pref "declared:" (symbol->string s))))

          ;; Lam [List-of Symbol] -> Lam
          ;; Accumulator declareds is a list of all λ
          ;; parameters on the path from le0 to le.
          (define (undeclareds/a le declareds)
            (cond
              [(symbol? le)
               (if (member? le declareds) (build-name "" le) (build-name "un" le))]
              [(lexpr? le)
               (local ((define param (first (lexpr-param le)))
                       (define body (lexpr-body le))
                       (define newd (cons param declareds)))
                 (make-lexpr (list param)
                       (undeclareds/a body newd)))]
              [(lapp? le)
               (local ((define fun (lapp-fun le))
                       (define arg (lapp-arg le)))
                 (make-lapp (undeclareds/a fun declareds)
                       (undeclareds/a arg declareds)))])))

    (undeclareds/a le0 '())))

