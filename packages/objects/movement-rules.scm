;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define movement-rules
  (create-package 'movement-rules
                  '()
                  '()))

(add-child! rules movement-rules)
(append! all-packages (list movement-rules))
(load "adventure-game/packages/objects/can-go-both-ways")
