;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-488) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 488.
;; Compare f(n) = n * log(n) and g(n) = n2 (expt).
;; Does f belong to O(g) or g to O(f)?


#|

f(n) = n * log(n)
g(n) = n2 (expt)


n       1     3     5     10      12      20       30

f(n)    0     ~5    ~12   ~33     ~43     ~86      ~147

g(n)    2     8     32    1024    4096    1048576  1073741824


f belong to O(g).

|#

