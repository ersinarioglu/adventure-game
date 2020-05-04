;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define stationary-thing
  (create-package 'stationary-thing
		  (list (lambda () ('thing 'black-board 10-250))
                        (lambda () ('thing 'lovely-trees great-court))
                        (lambda () ('thing 'flag-pole great-court))
                        (lambda () ('thing 'calder-sculpture the-dot)))
                  '()
                  (list 'place)))


