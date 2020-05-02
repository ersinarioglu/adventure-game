;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define stationary-thing
  (create-package 'stationary-thing
                  (list (list 'black-board '10-250)
                        (list 'lovely-trees 'great-court)
                        (list 'flag-pole 'great-court)
                        (list 'calder-sculpture 'the-dot))
                  '()))
