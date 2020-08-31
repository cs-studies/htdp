;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-419) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 419.


(define JANUS
  (list 31.0
        #i2e+34
        #i-1.2345678901235e+80
        2749.0
        -2939234.0
        #i-2e+33
        #i3.2e+270
        17.0
        #i-2.4e+270
        #i4.2344294738446e+170
        1.0
        #i-8e+269
        0.0
        99.0))


(define (sum l)
  (foldl + 0 l))

(sum JANUS)
;; #i99.0
(sum (reverse JANUS))
;; #i-1.2345678901234999e+80
(sum (sort JANUS <))
;; #i0.0

(expt 2 #i53.0)
;; #i9007199254740992.0
(sum (list #i1.0 (expt 2 #i53.0)))
;; #i9007199254740992.0
(sum (list #i1.0 #i1.0 (expt 2 #i53.0)))
;; #i9007199254740994.0

(exact->inexact (sum (map inexact->exact JANUS)))
;; #i4.2344294738446e+170

