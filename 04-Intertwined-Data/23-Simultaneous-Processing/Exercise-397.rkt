;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-397) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 397.
;; Design wages*.v3.
;; The function consumes a list of employee records
;; and a list of time-card records.
;; It produces a list of wage records,
;; which contain the name and weekly wage of an employee.
;; The function signals an error
;; if it cannot find an employee record for a time card or vice versa.
;; There is at most one time card per employee number.


;;; Data Definitions

(define-struct employee [name ssn rate])
;; An Employee is a structure:
;;    (make-employee String Number Number)
;; (make-employee n ssn r) represents an employee
;; with the name n, social security number ssn,
;; and the pay rate r.

(define-struct timecard [ssn hours])
;; A Timecard is a structure:
;;     (make-timecard Number Number)
;; (make-timecard ssn h) represents an electronic time card
;; that contains an employee ssn and
;; the number of hours worked per week.

(define-struct wage [employee amount])
;; A Wage is a structure:
;;    (make-wage String Number)
;; (make-wage n a) represents a weekly wage amount a
;; of an employee with the name n.


;;; Constants

(define ERR-TIMECARD "Time card not found")
(define ERR-EMPLOYEE "Employee not found")

(define e-1 (make-employee "Dan" 22222 25))
(define e-2 (make-employee "Emily" 33333 35))
(define e-3 (make-employee "Maxine" 44444 45))

(define t-1 (make-timecard 22222 12))
(define t-2 (make-timecard 33333 4))
(define t-3 (make-timecard 44444 1))


;;; Functions

;; [List-of Employee] [List-of Timecard] -> [List-of Wage]
;; Produces a list of weekly wages grouped by employees.
;; Signals an error if employee record or time card is not found.
(check-expect (wages* '() '()) '())
(check-expect (wages* `(,e-1) `(,t-1)) (list (make-wage "Dan" 300)))
(check-expect (wages* `(,e-1 ,e-2) `(,t-1 ,t-2))
              (list (make-wage "Dan" 300)
                    (make-wage "Emily" 140)))
(check-expect (wages* `(,e-1 ,e-2 ,e-3) `(,t-1 ,t-2 ,t-3))
              (list (make-wage "Dan" 300)
                    (make-wage "Emily" 140)
                    (make-wage "Maxine" 45)))
(check-error (wages* `(,e-1) '()) ERR-TIMECARD)
(check-error (wages* `(,e-1) `(,t-2 ,t-3)) ERR-TIMECARD)
(check-error (wages* `() `(,t-1 ,t-2)) ERR-EMPLOYEE)
(check-error (wages* `(,e-1 ,e-3) `(,t-1 ,t-2 ,t-3)) ERR-EMPLOYEE)
(define (wages* loe lot)
  (cond
    [(empty? loe) (if (empty? lot) '() (error ERR-EMPLOYEE))]
    [else
     (local (;; Employee [List-of Timecard] -> Timecard
             (define (find e lot)
               (cond
                 [(empty? lot) (error ERR-TIMECARD)]
                 [else (if (= (employee-ssn e)
                              (timecard-ssn (first lot)))
                           (first lot)
                           (find e (rest lot)))]))

             (define e-timecard (find (first loe) lot))

             ;; Employee Timecard -> Wage
             (define (create-wage e t)
               (make-wage (employee-name e)
                          (* (employee-rate e) (timecard-hours t)))))

       (cons (create-wage (first loe) e-timecard)
             (wages* (rest loe)
                     (remove e-timecard lot))))]))

