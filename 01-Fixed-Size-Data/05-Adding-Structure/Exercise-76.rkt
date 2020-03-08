;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-76) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 76.
;; Formulate data definitions for the following structure type definitions:


(define-struct movie [title producer year])
;; A Movie is a structure:
;; (make-movie String String Number)
;; (make-movie t p y) represents a movie
;; with a title t
;; and a producer p,
;; released in a year y.


(define-struct person [name hair eyes phone])
;; A Person is a structure:
;; (make-person String String String String)
;; (make-person n h e p) represents a person
;; with a name n,
;; hair color h,
;; eyes color e,
;; and a phone number p.

(define-struct pet [name number])
;; A Pet is a structure:
;; (make-pet String Number)
;; (make-pet n num) represents a pet
;; with a name n
;; and a pet's ID equal to num.

(define-struct CD [artist title price])
;; A CD is a structure:
;; (make-CD String String Number)
;; (make-CD a t p) represents a CD
;; by an artist a
;; with a title t
;; costing price p.

(define-struct sweater [material size producer])
;; A Sweater is a structure:
;; (make-sweater String Number String)
;; (make-sweater m s p) represents a sweater
;; made from material m,
;; of size s,
;; produced by p.

