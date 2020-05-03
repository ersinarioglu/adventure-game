;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define can-go-both-ways
  (create-package 'can-go-both-ways
                  (map (lambda (args) `(both-ways ,args))
		       '((lobby-10 up down 10-250)
			 (10-250 up down barker-library)
			 (barker-library up down great-dome)
			 (lobby-10 west east lobby-7)
			 (lobby-7 west east dorm-row)
			 (lobby-7 up down little-dome)
			 (lobby-10 south north great-court)
			 (lobby-10 east west infinite)
			 (infinite north south bldg-26)
			 (infinite east west bldg-54)
			 (bldg-26 east west student-street)
			 (student-street down up cp32)
			 (cp32 south north tunnel)
			 (tunnel up down bldg-54)
			 (bldg-54 south north the-dot)
                         (the-dot west east great-court)
                         (student-street in out 32-123)
                         (student-street up down 32G)
                         (student-street skew down 32D)))
                  '()))
(add-child! movement-rules can-go-both-ways)
(append! all-packages (list can-go-both-ways))
