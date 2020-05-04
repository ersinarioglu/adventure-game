;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define can-go-both-ways
  (create-package 'can-go-both-ways
                  (list (lambda () ('both-ways lobby-10 'up 'down 10-250))
			(lambda () ('both-ways 10-250 'up 'down barker-library))
			(lambda () ('both-ways barker-library 'up 'down great-dome))
			(lambda () ('both-ways lobby-10 'west 'east lobby-7))
			(lambda () ('both-ways lobby-7 'west 'east dorm-row))
			(lambda () ('both-ways lobby-7 'up 'down little-dome))
			(lambda () ('both-ways lobby-10 'south 'north great-court))
			(lambda () ('both-ways lobby-10 'east 'west infinite))
			(lambda () ('both-ways infinite 'north 'south bldg-26))
			(lambda () ('both-ways infinite 'east 'west bldg-54))
			(lambda () ('both-ways bldg-26 'east 'west student-street))
			(lambda () ('both-ways student-street 'down 'up cp32))
			(lambda () ('both-ways cp32 'south 'north tunnel))
			(lambda () ('both-ways tunnel 'up 'down bldg-54))
			(lambda () ('both-ways bldg-54 'south 'north the-dot))
                        (lambda () ('both-ways the-dot 'west 'east great-court))
                        (lambda () ('both-ways student-street 'in 'out 32-123))
                        (lambda () ('both-ways student-street 'up 'down 32G))
                        (lambda () ('both-ways student-street 'skew 'down 32D)))
                  '()
                  (list 'movement-rules)))


