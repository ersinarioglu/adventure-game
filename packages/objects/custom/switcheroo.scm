(define switcheroos-to-build
  '(electronic-doohickey shiny-metallic-ball))

(define switcheroo
  (create-package 'switcheroo
		  (map (lambda (args)
			 `(switcheroo-button ,args))
		       switcheroos-to-build)
		  '()
                  '(mobile-thing interaction aware-thing)
		  (lambda (things-to-build symbolic-definer)
		    (let ((objects (map build things-to-build)))
		      (set-switcheroo-instance (first objects) (second objects))
		      (set-swticheroo-instance (second objects) (first objects)))
		    objects)))
