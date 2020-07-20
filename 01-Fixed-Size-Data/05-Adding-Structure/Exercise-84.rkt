;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-84) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 84.
;; Design the function edit,
;; which consumes two inputs, an editor ed and a KeyEvent ke,
;; and it produces another editor.


;;; Constants and Data Definitions

(define-struct editor [pre post])
;; An Editor is a structure:
;;   (make-editor String String)
;; (make-editor s t) describes an editor
;; whose visible text is (string-append s t) with
;; the cursor displayed between s and t


;;; Functions

;; Editor KeyEvent -> Editor
;; Produces an editor based on given parameters.
(define ed1 (make-editor "hi" "fi"))
(define ed2 (make-editor "" "fi"))
(check-expect (edit ed1 "g") (make-editor "hig" "fi"))
(check-expect (edit ed2 "g") (make-editor "g" "fi"))
(check-expect (edit ed1 "h") (make-editor "hih" "fi"))
(check-expect (edit ed1 " ") (make-editor "hi " "fi"))
(check-expect (edit ed1 "\b") (make-editor "h" "fi"))
(check-expect (edit ed2 "\b") (make-editor "" "fi"))
(check-expect (edit ed1 "") (make-editor "hi" "fi"))
(check-expect (edit ed1 "\t") (make-editor "hi" "fi"))
(check-expect (edit ed1 "\r") (make-editor "hi" "fi"))
(check-expect (edit ed1 "left") (make-editor "h" "ifi"))
(check-expect (edit (make-editor "h" "ifi") "left") (make-editor "" "hifi"))
(check-expect (edit (make-editor "" "hifi") "left") (make-editor "" "hifi"))
(check-expect (edit ed1 "right") (make-editor "hif" "i"))
(check-expect (edit (make-editor "hif" "i") "right") (make-editor "hifi" ""))
(check-expect (edit (make-editor "hifi" "") "right") (make-editor "hifi" ""))
(define (edit ed ke)
  (cond
    [(string=? ke "left")
     (make-editor
      (string-remove-last (editor-pre ed))
      (string-append (string-last (editor-pre ed)) (editor-post ed)))]
    [(string=? ke "right")
     (make-editor
      (string-append (editor-pre ed) (string-first (editor-post ed)))
      (string-remove-first (editor-post ed)))]
    [(string=? ke "\b")
     (make-editor
      (string-remove-last (editor-pre ed))
      (editor-post ed))]
    [(and (= (string-length ke) 1)
          (not (string=? ke "\t"))
          (not (string=? ke "\r")))
     (make-editor
      (string-append (editor-pre ed) ke)
      (editor-post ed))]
    [else ed]))

;; String -> String
;; Returns the first character of a given string.
(check-expect (string-first "Str") "S")
(check-expect (string-first "S") "S")
(check-expect (string-first "") "")
(define (string-first s)
  (if (> (string-length s) 1)
      (substring s 0 1)
      s))

;; String -> String
;; Returns a given string without the first character.
(check-expect (string-remove-first "Str") "tr")
(check-expect (string-remove-first "S") "")
(check-expect (string-remove-first "") "")
(define (string-remove-first s)
  (if (> (string-length s) 0)
      (substring s 1)
      s))

;; String -> String
;; Returns the last character of a given string.
(check-expect (string-last "Str") "r")
(check-expect (string-last "r") "r")
(check-expect (string-last "") "")
(define (string-last s)
  (if (> (string-length s) 0)
      (substring s (- (string-length s) 1))
      s))

;; String -> String
;; Returns a given string without the last character.
(check-expect (string-remove-last "Str") "St")
(check-expect (string-remove-last "r") "")
(check-expect (string-remove-last "") "")
(define (string-remove-last s)
  (if (> (string-length s) 0)
      (substring s 0 (- (string-length s) 1))
      s))

