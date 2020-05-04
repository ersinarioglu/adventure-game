;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define house-master
  (create-package 'house-master
                  (list (lambda (args)
			  (lambda ()
			    `(house-master ,args)))
			'(dr-evil mr-bigglesworth))
                  '()
                  (list 'autonomous-agent)))


