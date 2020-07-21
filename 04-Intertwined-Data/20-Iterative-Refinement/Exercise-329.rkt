;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-329) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 329.

;;; Question
;; How many times does a file name read! occur in the directory tree TS?
;;; Answer
;; 2 times.

;;; Question
;; Can you describe the path from the root directory to the occurrences?
;;; Answer
;; Yes:
;; - TS/read!
;; - TS/Libs/Docs/read!

;;; Question
;; What is the total size of all the files in the tree?
;;; Answer
(+ 10 99 52 17 8 2 19)
;= 207

;;; Question
;; What is the total size of the directory if each directory node has size 1?
;;; Answer
(+ 207 5)
;= 212

;;; Question
;; How many levels of directories does it contain?
;;; Answer
;; 3 levels.

