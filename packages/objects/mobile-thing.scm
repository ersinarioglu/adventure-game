;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define mobile-thing
  (create-package 'mobile-thing
                  '((mobile-thing engineering-book))
                  (list 'people)
                  (list 'place)))

(append! all-packages (list mobile-thing))
(load "adventure-game/packages/objects/people")

