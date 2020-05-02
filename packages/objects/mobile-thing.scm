;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define mobile-thing
  (create-package 'mobile-thing
                  (list 'engineering-book)
                  (list 'people)))

(load "adventure-game/packages/objects/people")

