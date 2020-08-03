;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-382) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;
;; Exercise 382.
;; Formulate an XML configuration for the BW machine,
;; which switches from white to black and back for every key event.
;; Translate the XML configuration into an XMachine representation.
;; See exercise 227 for an implementation of the machine as a program.


#|
<machine initial="white">
  <action state="white" next="black" />
  <action state="black" next="white" />
</machine>
|#

'(machine ((initial "white"))
          (action ((state "white") (next "black")))
          (action ((state "black") (next "white"))))

