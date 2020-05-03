;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define rules
  (create-package 'rules
                  '()
                  '()))
                        
(add-child! place rules)
(append! all-packages (list rules))
(load "adventure-game/packages/objects/movement-rules")
(load "adventure-game/packages/objects/visibility-rules")
