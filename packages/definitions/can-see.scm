;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Handler for build method
(define (can-see args)
  (let ((a (first args))
	(b (second args)))
    (add-vista! a b)))

(add-build-handler 'can-see can-see)
