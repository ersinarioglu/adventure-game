;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Container package
(define container
  (create-package 'container
                  '()
                  (list 'place)
                  (list 'thing)))

(append! all-packages (list container))
(load "adventure-game/packages/objects/place")
