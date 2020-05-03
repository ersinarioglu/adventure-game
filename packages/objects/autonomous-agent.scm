;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define autonomous-agent
  (create-package 'autonomous-agent
                  '()
                  '()))

(add-child! people autonomous-agent)
(append! all-packages (list autonomous-agent))
(load "adventure-game/packages/objects/avatar")
(load "adventure-game/packages/objects/troll")
(load "adventure-game/packages/objects/student")
(load "adventure-game/packages/objects/house-master")
