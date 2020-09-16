;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-476) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 476.
;; Design the function fsm-match.
;; It consumes the data representation of a finite state machine and a string.
;; It produces #true if the sequence of characters in the string
;; causes the finite state machine to transition from an initial state to a final state.


;; An FSM-State is String.

(define-struct transition [current key next])
;; A 1Transition is a structure:
;;   (make-transition FSM-State 1String FSM-State)

(define-struct fsm [initial transitions final])
;; An FSM is a structure:
;;   (make-fsm FSM-State [List-of 1Transition] FSM-State)

(define fsm-a-bc*-d
  (make-fsm
   "AA"
   (list (make-transition "AA" "a" "BC")
         (make-transition "BC" "b" "BC")
         (make-transition "BC" "c" "BC")
         (make-transition "BC" "d" "DD"))
   "DD"))

;; FSM String -> Boolean
;; Determines whether an-fsm recognize the given string.
(check-expect (fsm-match? fsm-a-bc*-d "") #false)
(check-expect (fsm-match? fsm-a-bc*-d "aa") #false)
(check-expect (fsm-match? fsm-a-bc*-d "ba") #false)
(check-expect (fsm-match? fsm-a-bc*-d "cd") #false)
(check-expect (fsm-match? fsm-a-bc*-d "ad") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abcd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "acbd") #true)
(check-expect (fsm-match? fsm-a-bc*-d "abbbd") #true)
(define (fsm-match? an-fsm a-string)
  (cond
    [(= 0 (string-length a-string)) #false]
    [else
     (local (
             (define a-key (string-ith a-string 0))
             (define a-state (fsm-initial an-fsm))
             (define transitions (fsm-transitions an-fsm))
             (define final (fsm-final an-fsm))

             (define (find-transition transitions)
               (cond
                 [(empty? transitions) #false]
                 [else
                  (local ((define t (first transitions)))
                    (if (and
                         (string=? a-state (transition-current t))
                         (string=? a-key (transition-key t)))
                        t
                        (find-transition (rest transitions))))]))

             (define this-transition (find-transition transitions))

             (define (final-state? t)
               (and (= 1 (string-length a-string))
                    (string=? (transition-next t) final)))

             (define (possible-transitions trs)
               (local ((define possible-states
                         (map (lambda (t) (transition-next t)) trs)))
                 (filter
                  (lambda (t) (member? (transition-current t) possible-states))
                  trs))))

       (cond
         [(false? this-transition) #false]
         [(final-state? this-transition) #true]
         [else (fsm-match?
                (make-fsm (transition-next this-transition)
                          (possible-transitions transitions)
                          final)
                (substring a-string 1))]))]))

