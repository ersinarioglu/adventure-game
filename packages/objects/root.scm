;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; root package of package dependency tree

(define root
  (create-package 'root  ;name
                  (list 'thing)    ;children
                  '()))  ;parent

(load "adventure-game/packages/objects/thing") 
