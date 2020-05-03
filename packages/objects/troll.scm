;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define troll
  (create-package 'troll
                  (map (lambda (args) `(troll ,args))
		       '(grendel
                        'registrar))
                  '()))

(add-child! autonomous-agent troll)
(append! all-packages (list troll))
