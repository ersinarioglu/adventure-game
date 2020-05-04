;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define mobile-thing
  (create-package 'mobile-thing
                  (list 'people)
                  (list 'place)))


(load "adventure-game/packages/objects/people")

