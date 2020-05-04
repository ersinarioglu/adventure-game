;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define can-see-both-ways
  (create-package 'can-see-both-ways
                  (map (lambda (args) `(can-see-both-ways ,@args))
		       '((32D 32G)
                         (great-dome little-dome)
                         (lobby-10 infinite)
                         (lobby-7 infinite)
                         (infinite bldg-26)
                         (lobby-10 lobby-7)))
                  '()
                  (list 'can-see)))

(append! all-packages (list can-see-both-ways))
