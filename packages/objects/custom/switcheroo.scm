(define switcheroos-to-build
  '(electronic-doohickey shiny-metallic-ball))

(define switcheroo
  (create-package 'switcheroo
		  (map (lambda (args)
			 (lambda ()
			 `(switcheroo-button ,args)))
		       switcheroos-to-build)
		  '()
                  '(mobile-thing interaction aware-thing)
		  (lambda (things-to-build symbol-definer)
		    (let ((objects (map (lambda (thunk)
					  (build (thunk)))
					things-to-build)))
		      (for-each (lambda (name obj)
				  (symbol-definer name obj))
				switcheroos-to-build objects))
		      (set-switcheroo-instance electronic-doohickey shiny-metallic-ball)
		      (set-swticheroo-instance shiny-metallic-ball electronic-doohickey)
		    objects)))
