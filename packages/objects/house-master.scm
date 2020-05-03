;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define house-master
  (create-package 'house-master
                  (map (lambda (args) `(house-master ,@args))
		       '((dr-evil)
			 (mr-bigglesworth)))
                  '()))

(add-child! autonomous-agent house-master)
(append! all-packages (list house-master))
