;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define thing
  (create-package 'thing
                  '()
                  '()))

(add-child! root thing)
(append! all-packages (list thing))
(load "adventure-game/packages/objects/container") 


