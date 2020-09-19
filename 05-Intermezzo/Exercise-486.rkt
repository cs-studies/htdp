;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-486) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 486.
;; We stated that the function f(n) = n2 + n belongs to the class O(n2).
;; Determine the pair of numbers c and bigEnough that verify this claim.


#|

f(n) = n2 + n
g(n) = n2


n          1     10    100     1000      2000

f(n)       2     110   10100   1001000   2002000

c=1
g(n)       1     100   10000   1000000   2000000

c=2
g(n)       2     200   20000   2000000   4000000


For bigEnough = 1 and c = 2,

f(n) <= 2 * g(n) for every n >= 1.

Hence f(n) belongs to the class O(n2).

|#

