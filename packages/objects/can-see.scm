;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define can-see
  (create-package 'can-see
                  (map (lambda (args) `(can-see ,@args))
		       '((bldg-54 32G)
                         (bldg-54 32D)
                         (bldg-54 great-dome)
                         (bldg-54 little-dome)
                         (bldg-54 great-court)
                         (bldg-54 the-dot)
                         (lobby-10 great-court)
                         (great-dome great-court)))
                  (list 'can-see-both-ways)))

(load "adventure-game/packages/objects/can-see-both-ways")
