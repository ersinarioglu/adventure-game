;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define can-see
  (create-package 'can-see
                  (list 'can-see-both-ways)
                  'visibility-rules))

(load "adventure-game/packages/objects/can-see-both-ways")
