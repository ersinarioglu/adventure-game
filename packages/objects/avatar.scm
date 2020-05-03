;;; 6.905 Final Project
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define avatar
  (create-package 'avatar
                  '(avatar my-name)
                  '()))

(add-child! autonomous-agent avatar)
(append! all-packages (list avatar))
