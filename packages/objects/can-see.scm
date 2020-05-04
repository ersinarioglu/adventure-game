;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define can-see
  (create-package 'can-see
                  (list (lambda () ('can-see bldg-54 32G))
                        (lambda () ('can-see bldg-54 32D))
                        (lambda () ('can-see bldg-54 great-dome))
                        (lambda () ('can-see bldg-54 little-dome))
                        (lambda () ('can-see bldg-54 great-court))
                        (lambda () ('can-see bldg-54 the-dot))
                        (lambda () ('can-see lobby-10 great-court))
                        (lambda () ('can-see great-dome great-court)))
                  (list 'can-see-both-ways)
                  (list 'visibility-rules)))

(load "adventure-game/packages/objects/can-see-both-ways")
