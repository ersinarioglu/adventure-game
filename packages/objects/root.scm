;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; root package of package dependency tree

(define root
  (create-package 'root  ;name
                  '()    ;things to build
                  (list 'thing)    ;children
                  '()))  ;parent

(define all-packages (list root))
(load "adventure-game/packages/objects/thing") 
