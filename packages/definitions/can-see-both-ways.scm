;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Handler for build method

(define (can-see-both-ways a b)
  (can-see a b)
  (can-see b a))

(add-build-handler 'can-see-both-ways can-see-both-ways)
