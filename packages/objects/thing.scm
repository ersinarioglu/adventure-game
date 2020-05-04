;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define thing
  (create-package 'thing
                  (list 'container)
                  (list 'root)))

(load "adventure-game/packages/objects/container") 


