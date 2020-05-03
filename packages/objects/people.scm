;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define people
  (create-package 'people
                  '()
                  '()))

(add-child! mobile-thing people)
(append! all-packages (list people))
(load "adventure-game/packages/objects/autonomous-agent")


