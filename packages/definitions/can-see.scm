;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Handler for build method
(define (can-see a b)
  (add-vista! a b))

(add-build-handler 'can-see can-see)
