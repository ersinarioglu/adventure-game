;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define can-see
  (create-package 'can-see
                  (list (list bldg-54 32G)
                        (list bldg-54 32D)
                        (list bldg-54 great-dome)
                        (list bldg-54 little-dome)
                        (list bldg-54 great-court)
                        (list bldg-54 the-dot)
                        (list lobby-10 great-court)
                        (list great-dome great-court))
                  (list can-see-both-ways)))
