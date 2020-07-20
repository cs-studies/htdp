;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-31) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 31.
;; Create appropriate files, launch main, and check
;; whether it delivers the expected letter in a given file.

(require 2htdp/batch-io)

;;; Batch Program From the Exercise
(define (main in-fst in-lst in-signature out)
  (write-file out
              (letter (read-file in-fst)
                      (read-file in-lst)
                      (read-file in-signature))))

;;; Letter Program From https://htdp.org/2019-02-24/part_one.html#%28part._sec~3acomposing%29
(define (letter fst lst signature-name)
  (string-append
    (opening fst)
    "\n\n"
    (body fst lst)
    "\n\n"
    (closing signature-name)))

(define (opening fst)
  (string-append "Dear " fst ","))

(define (body fst lst)
  (string-append
   "We have discovered that all people with the" "\n"
   "last name " lst " have won our lottery. So, " "\n"
   fst ", " "hurry and pick up your prize."))

(define (closing signature-name)
  (string-append
   "Sincerely,"
   "\n\n"
   signature-name
   "\n"))

;; Definitions
(define FST "./files/fst.txt")
(define LST "./files/lst.txt")
(define SIGNATURE "./files/signature.txt")
(define OUT "./files/out.txt")

;; Application
(write-file FST "Jean")
(write-file LST "Jennings")
(write-file SIGNATURE "Bartik")

(main FST LST SIGNATURE OUT)

(write-file 'stdout (string-append (read-file OUT) "\n"))

