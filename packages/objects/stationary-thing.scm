;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define stationary-thing
  (create-package 'stationary-thing
		  (map (lambda (args) `(thing ,args))
		       '((black-board 10-250)
                         (lovely-trees great-court)
                         (flag-pole great-court)
                         (calder-sculpture the-dot)))
                  '()
                  (list 'place)))

(append! all-packages stationary-thing)
