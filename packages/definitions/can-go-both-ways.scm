;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Handler for build method

(define (can-go-both-ways from direction reverse-direction to)
  (create-exit from direction to)
  (create-exit to reverse-direction from))

(define (create-both-ways args)
  (let ((from (first args))
	(direction (second args))
	(reverse-direction (third args))
	(to (fourth args)))
    (can-go-both-ways from direction reverse-direction to)))

(add-build-handler 'both-ways create-both-ways)
