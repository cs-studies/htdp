;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-129) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 129.
;; Create BSL lists that represent:


;; a list of celestial bodies, say, at least all the planets in our solar system
(cons "Neptune"
      (cons "Uranus"
            (cons "Saturn"
                  (cons "Jupiter"
                        (cons "Mars"
                              (cons "Earth"
                                    (cons "Venus"
                                          (cons "Mercury"
                                                '()))))))))

;; a list of items for a meal
(cons "Mandarin"
      (cons "Apple"
            (cons "Coconut"
                  (cons "Honey"
                        (cons "Cinnamon"
                              (cons "Cardamom"
                                    '()))))))

;; a list of colors
(cons "red"
      (cons "green"
            (cons "blue"
                  '())))


;;; Question
;; Which of the sketches do you like better?

;;; Answer
;; The sketches that list the boxes in the order in which they are consed together.

