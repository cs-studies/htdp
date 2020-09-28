;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-520) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 520.
;; The solve* function generates all states reachable with n boat trips
;; before it looks at states that require n + 1 boat trips,
;; even if some of those boat trips return to previously encountered states.
;; Because of this systematic way of traversing the tree,
;; solve* cannot go into an infinite loop. Why?


;; PuzzleState -> PuzzleState
;; Is the final state reachable from state0
;; Generative: creates a tree of possible boat rides
(check-expect (solve initial-puzzle) final-puzzle)
(define (solve state0)
  (local (;; [List-of PuzzleState] -> PuzzleState
          ;; Generative: generates the successors of los.
          (define (solve* los)
            (cond
              [(ormap final? los)
               (first (filter final? los))]
              [else
               (solve* (create-next-states los))])))
    (solve* (list state0))))

;;; Answer
;; Because this is the trivial case that determines the termination
;; of the solve* function.
;; Let's los - passed to solve* - contain the final state
;; and the function doesn't terminate at this point,
;; recursively generating new states.
;; Then, by induction, the function infinitely checks generated states,
;; on each recursive call, without termination.

