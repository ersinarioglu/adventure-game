;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define can-see-both-ways
  (create-package 'can-see-both-ways
                  (list (lambda () ('can-see-both-ways 32d 32g))
                        (lambda () ('can-see-both-ways great-dome little-dome))
                        (lambda () ('can-see-both-ways lobby-10 infinite))
                        (lambda () ('can-see-both-ways lobby-7 infinite))
                        (lambda () ('can-see-both-ways infinite bldg-26))
                        (lambda () ('can-see-both-ways lobby-10 lobby-7)))
                  '()
                  (list 'can-see)))


