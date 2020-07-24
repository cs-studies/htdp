;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-342) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 342.
;; Design find.
;; The function consumes a directory d and a file name f.
;; If (find? d f) is #true, find produces a path to a file with name f;
;; otherwise it produces #false.
;;
;; Design find-all.


;; A Path is [List-of String].

(define-struct file [name size content])
;; A File is a structure:
;;   (make-file String N String)

(define-struct dir [name dirs files])
;; A Dir is a structure:
;;    (make-dir String [List-of Dir] [List-of File])


(define Dir-Text
  (make-dir "Text"
            '()
            (list
             (make-file "part1" 99 "")
             (make-file "part2" 52 "")
             (make-file "part3" 17 ""))))

(define Dir-Code
  (make-dir "Code"
            '()
            (list
             (make-file "hang" 8 "")
             (make-file "draw" 2 ""))))

(define Dir-Docs
  (make-dir "Docs"
            '()
            (list
             (make-file "read!" 19 ""))))

(define Dir-Libs
  (make-dir "Libs"
            (list Dir-Code Dir-Docs)
            '()))

(define Dir-TS
  (make-dir "TS"
            (list Dir-Text Dir-Libs)
            (list
             (make-file "read!" 10 ""))))

(define Dir-Empty (make-dir "Empty" '() '()))


;; Dir String -> [Maybe Path]
;; Produces a path to a file with the given name.
;; Otherwise produces #false.
(check-expect (find Dir-Empty "Test") #false)
(check-expect (find Dir-TS "Test") #false)
(check-expect (find Dir-TS "read!") '("TS" "read!"))
(check-expect (find Dir-TS "part1") '("TS" "Text" "part1"))
(check-expect (find Dir-TS "hang") '("TS" "Libs" "Code" "hang"))
(check-expect (find (make-dir "Test" (list Dir-TS) '()) "hang")
              '("Test" "TS" "Libs" "Code" "hang"))

(define (find d name)
  (local (
          (define found-in-files
            (ormap (lambda (f) (string=? (file-name f) name)) (dir-files d)))

          (define found-in-dirs
            (if (empty? (dir-dirs d)) #false (find-in-dirs (dir-dirs d) name)))

          (define (find* d)
            (if (not (false? found-in-files))
                (cons name '())
                (if (not (false? found-in-dirs))
                    found-in-dirs
                    #false)))

          (define found (find* d)))

    (if (not (false? found))
        (cons (dir-name d) found)
        #false)))


;; Dir String -> [List-of Path]
;; Produces paths to the files with the given name.
;; Otherwise produces empty list.
(check-expect (find-all Dir-Empty "Test") '())
(check-expect (find-all Dir-TS "Test") '())
(check-expect (find-all Dir-TS "read!") '(("TS" "read!") ("TS" "Libs" "Docs" "read!")))
(check-expect (find-all Dir-TS "part1") '(("TS" "Text" "part1")))
(check-expect (find-all Dir-TS "hang") '(("TS" "Libs" "Code" "hang")))
(check-expect (find-all (make-dir "Test" (list Dir-TS) '()) "hang")
              '(("Test" "TS" "Libs" "Code" "hang")))
(define (find-all d name)
  (local (
          (define found-in-files
            (if (ormap (lambda (f) (string=? (file-name f) name)) (dir-files d))
                (cons name '())
                #false))

          (define found-in-dirs
            (if (empty? (dir-dirs d)) #false (find-in-dirs (dir-dirs d) name))))

    (append
     (if (not (false? found-in-files))
         (list (cons (dir-name d) found-in-files))
         '())
     (if (not (false? found-in-dirs))
         (list (cons (dir-name d) found-in-dirs))
         '()))))


;; [List-of Dir] String -> [Maybe Path]
;; Produces a path to the file with the given name
;; If file is not found, returns false.
(define (find-in-dirs lod name)
  (local ((define found-in-dir
            (if (empty? lod) #false (find (first lod) name))))
    (cond
      [(empty? lod) #false]
      [else (if (not (false? found-in-dir))
                found-in-dir
                (find-in-dirs (rest lod) name))])))

