;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-339) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 339.
;; Design find?.
;; The function consumes a Dir and a file name
;; and determines whether or not a file with this name
;; occurs in the directory tree.


(require htdp/dir)
(require 2htdp/abstraction)


;; Dir String -> Boolean
;; Determines whether a file with the given name
;; occurs in the directory tree.
(check-expect (find? (create-dir "./") "Blockbuster.png") #false)
(check-expect (find? (create-dir "../") "Blockbuster.png") #false)
(check-expect (find? (create-dir "./") "Exercise-339.rkt") #true)
(check-expect (find? (create-dir "../../") "Exercise-339.rkt") #true)

(define (find? d name)
  (or
   (for/or ([f (dir-files d)]) (string=? (file-name f) name))
   (for/or ([d (dir-dirs d)]) (find? d name))))

#|
(define (find? d name)
  (or
   (ormap (lambda (f) (string=? (file-name f) name)) (dir-files d))
   (ormap (lambda (d) (find? d name)) (dir-dirs d))))
|#

#|
(define (find? d name)
  (or (find-in-files? (dir-files d) name)
      (find-in-dirs? (dir-dirs d) name)))

(define (find-in-files? lof name)
  (cond
    [(empty? lof) #false]
    [else (or (string=? (file-name (first lof)) name)
              (find-in-files? (rest lof) name))]))

(define (find-in-dirs? lod name)
  (cond
    [(empty? lod) #false]
    [else (or (find? (first lod) name)
              (find-in-dirs? (rest lod) name))]))
|#

