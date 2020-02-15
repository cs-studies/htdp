#|
Exercise 12. Define the function cvolume, which accepts the length of a side of an equilateral cube and computes its volume. If you have time, consider defining csurface, too.
|#

; Functions
(define (cvolume length) (expt length 3))
(define (csurface length) (* (sqr length) 6))