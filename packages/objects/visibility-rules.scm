;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define visibility-rules
  (create-package 'visibility-rules
                  '()
                  '()))

(add-child! rules visibility-rules)
(append! all-packages (list visibility-rules)) 
(load "adventure-game/packages/objects/can-see")

