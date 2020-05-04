;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Container package
(define container
  (create-package 'container
                  (list 'place)
                  'thing))

(load "adventure-game/packages/objects/place")
