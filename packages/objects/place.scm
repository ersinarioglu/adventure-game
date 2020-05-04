;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Place package
(define all-places-to-build
  (list 'great-dome
   'little-dome
   'lobby-10
   '10-250
   'barker-library
   'lobby-7
   'infinite
   'bldg-26
   'cp32
   'tunnel
   '32-123
   '32G
   '32D
   'student-street
   'great-court
   'bldg-54
   'the-dot
   'dorm-row))

(define place
  (create-package 'place
                  (map (lambda (args) `(place ,args))
		       all-places-to-build)
                  (list 'rules 'mobile-thing 'stationary-thing)
                  (list 'container)
		  (lambda (things-to-build symbol-definer)
		    (let ((places (map build things-to-build)))
		      (symbol-definer 'all-places places)
		      places))))
                   
(append! all-packages (list place))

(load "adventure-game/packages/objects/rules")
(load "adventure-game/packages/objects/mobile-thing")
(load "adventure-game/packages/objects/stationary-thing")
