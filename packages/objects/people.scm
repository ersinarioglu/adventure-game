;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define people
  (create-package 'people
                  (list 'autonomous-agent)
                  (list 'mobile-thing)))


(load "adventure-game/packages/objects/autonomous-agent")


