;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-523) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 523.
;; Design the create-next-states function.
;; It consumes lists of missionary-and-cannibal states
;; and generates the list of all those states that a boat ride can reach.
;; Ignore the accumulator in the first draft of create-next-states,
;; but make sure that the function does not generate states
;; where the cannibals can eat the missionaries.
;; For the second design, update the accumulator field in the state structures
;; and use it to rule out states that have been encountered on the way to the current state. 


(require 2htdp/image)
(require 2htdp/abstraction)


(define MAX 3) ; max number of each actor type.

;; N is a natural number in the interval [0, MAX].

;; A Boat is one of:
;; - 'left
;; - 'right

(define-struct side [mis can])
;; A Side is a structure
;;   (make-side N N)
;; (make-side m c) represents
;; a number of m missionaries and c cannibals on the river bank.

(define-struct ps [left right boat parents])
;; A PuzzleState is a structure
;;   (make-ps Side Side Boat [List-of Parent])
;; (make-ps ls rs b p) represents a puzzle state
;; with the left side of the river ls,
;; the right side of the river rs,
;; the location of the boat b,
;; and the list of parents p.
;; Accumulator parents contains the list of states traversed,
;; with the most recent one placed on the left.

;; A Parent is a PuzzleState (make-ps Side Side Boat '())
;; Represents a PuzzleState without its parents information.

;; A Move is a [List-of N[0,MAX] N[0,MAX]]

(define BOAT-CAPACITY 2)

;; A list of possible moves according to the boat capacity.
;; For example: (list (list 0 1) (list 0 2) (list 1 0) (list 1 1) (list 2 0))
(define MOVES (filter (lambda(x) (< 0 (+ (first x) (second x)) MAX))
                      (for*/list ([i MAX] [j MAX]) (list i j))))

;; PuzzleState -> Parent
;; Converts PuzzleState to its Parent representation.
(check-expect (ps->p ps-1) (make-ps (make-side 3 3) (make-side 0 0) 'left '()))
(check-expect (ps->p ps-2-1) (make-ps (make-side 3 2) (make-side 0 1) 'right '()))
(define (ps->p state)
  (local ((define left (ps-left state))
          (define right (ps-right state)))
    (make-ps (make-side (side-mis left) (side-can left))
             (make-side (side-mis right) (side-can right))
             (ps-boat state)
             '())))

(define ps-1 (make-ps (make-side 3 3) (make-side 0 0) 'left '()))
(define ps-2-1 (make-ps (make-side 3 2) (make-side 0 1) 'right (list (ps->p ps-1))))
(define ps-2-2 (make-ps (make-side 3 1) (make-side 0 2) 'right (list (ps->p ps-1))))
(define ps-2-3 (make-ps (make-side 2 2) (make-side 1 1) 'right (list (ps->p ps-1))))
(define ps-3-1 (make-ps (make-side 3 2) (make-side 0 1) 'left
                        (list (ps->p ps-2-3) (ps->p ps-1))))
(define ps-3-2 (make-ps (make-side 3 2) (make-side 0 1) 'left
                        (list (ps->p ps-2-2) (ps->p ps-1))))


;; [List-of PuzzleState] -> [List-of PuzzleState]
;; Generates a list of the states that a boat ride can reach.
(check-expect (create-next-states '()) '())
(check-expect (create-next-states `(,ps-1)) `(,ps-2-3 ,ps-2-2 ,ps-2-1))
(check-expect (create-next-states `(,ps-2-3)) `(,ps-3-1)) ; no loop
(check-expect (create-next-states `(,ps-2-1 ,ps-2-2 ,ps-2-3)) `(,ps-3-2))
(define (create-next-states l0)
  (local
    ((define all-parents (parents l0))
     ;; [List-of PuzzleState] [List-of PuzzleState] -> [List-of PuzzleState]
     ;; Accumulator a contains the next states for already traversed items of l0.
     (define (create-next-states/a states a)
       (cond
         [(empty? states) a]
         [else
          (local
            ((define state (first states))
             (define is-left? (symbol=? 'left (ps-boat state)))
             (define from (if is-left? (ps-left state) (ps-right state)))
             (define to (if is-left? (ps-right state) (ps-left state)))
             (define parents (cons (ps->p state) (ps-parents state)))
             ;; [List-of Move] [List-of PuzzleState] [List-of Parent] -> [List-of PuzzleState]
             ;; Accumulator a contains the next states of one PuzzleState.
             (define (create-next-states/one/a moves a p-a)
               (cond
                 [(empty? moves) a]
                 [else
                  (local
                    ((define move (first moves))
                     (define (build-side actor op)
                       (make-side (op (side-mis actor) (first move))
                                  (op (side-can actor) (second move))))
                     (define candidate
                       (make-ps (if is-left? (build-side from -) (build-side to +))
                                (if is-left? (build-side to +) (build-side from -))
                                (if is-left? 'right 'left)
                                parents))
                     (define newacc?
                       (local ((define (valid? side)
                                 (local ((define m (side-mis side))
                                         (define c (side-can side)))
                                   (and (<= 0 m MAX) (<= 0 c MAX) (or (zero? m) (>= m c))))))
                         (and (valid? (ps-left candidate))
                              (valid? (ps-right candidate))
                              (not (member? (ps->p candidate) p-a))
                              (not (member? (ps->p candidate) all-parents))))))
                    (create-next-states/one/a (rest moves)
                                              (if newacc? (cons candidate a) a)
                                              (if newacc? (cons (ps->p candidate) p-a) p-a)))])))
            (create-next-states/a (rest states)
                                  (create-next-states/one/a MOVES a (map ps->p a))))])))
    (create-next-states/a l0 '())))


;; [List-of PuzzleState] -> [List-of Parent]
;; Generates a list of Sides and Boat values of the given states and their parents.
(check-expect (parents '()) '())
(check-expect (parents `(,ps-1))
              (list (make-ps (ps-left ps-1) (ps-right ps-1) 'left '())))
(check-expect (parents `(,ps-2-1))
              (list (make-ps (ps-left ps-1) (ps-right ps-1) 'left '())
                    (make-ps (ps-left ps-2-1) (ps-right ps-2-1) 'right '())))
(check-expect (parents `(,ps-1 ,ps-2-1))
              (list (make-ps (ps-left ps-1) (ps-right ps-1) 'left '())
                    (make-ps (ps-left ps-2-1) (ps-right ps-2-1) 'right '())))
(define (parents states0)
  (local
    ((define (parents/a states a)
       (cond
         [(empty? states) a]
         [else
          (local
            ((define (parents/one/a parents acc)
               (cond
                 [(empty? parents) acc]
                 [else
                  (local ((define p (ps->p (first parents)))
                          (define newacc (if (member? p acc) acc (cons p acc))))
                    (parents/one/a (rest parents) newacc))])))
            (parents/a (rest states) (parents/one/a (ps-parents (first states)) a)))])))
    (parents/a states0 (map ps->p states0))))

