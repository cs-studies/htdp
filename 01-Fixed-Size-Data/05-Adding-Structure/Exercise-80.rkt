;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-80) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 80.
;; Create templates for functions
;; that consume instances of the following structure types:


(define-struct movie [title director year])

(define (watch m)
  (... (movie-title m) ... (movie-director m) ... (movie-year m) ...))


(define-struct pet [name number])

(define (pat p)
  (... (pet-name p) ... (pet-number p) ...))


(define-struct CD [artist title price])

(define (play cd)
  (... (CD-artist cd) ... (CD-title cd) ... (CD-price cd) ...))


(define-struct sweater [material size color])

(define (buy s)
  (... (sweater-material s) ... (sweater-size s) ... (sweater-color s) ...))

