;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Place package

(define place
  (create-package 'place
                  (list 'rules 'mobile-thing 'stationary-thing)
                  (list 'container)))


(load "adventure-game/packages/objects/rules")
(load "adventure-game/packages/objects/mobile-thing")
(load "adventure-game/packages/objects/stationary-thing")
