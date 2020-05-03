;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Container package
(define container
  (create-package 'container
                  '()
                  '()))
(add-child! thing container)
(append! all-packages (list container))
(load "adventure-game/packages/objects/place")
