;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-487) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 487.
;; Consider the functions f(n) = 2n and g(n) = 1000 n.
;; Show that g belongs to O(f), which means that f is, abstractly speaking,
;; more (or at least equally) expensive than g.
;; If the input size is guaranteed to be between 3 and 12, which function is better?


#|

f(n) = 2n (expt)
g(n) = 1000*n


n       1     3     5     10      12      20       30

g(n)    1000  3000  5000  10000   12000   20000    30000

c=1
f(n)    2     8     32    1024    4096    1048576  1073741824

c=10
f(n)    20    80    320   10240   40960   10485760 10737418240


g(n) belongs to O(f).

But for small inputs and small constant c, f(n) is more efficient,
so for input size between 3 and 12 it's better to use f(n).

|#

