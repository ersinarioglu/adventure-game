;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Place package
(define all-places
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
                  all-places
                  (list 'rules
                        'mobile-thing
                        'stationary-thing)))


