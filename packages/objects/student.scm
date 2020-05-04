;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define student
  (create-package 'student
                  (map (lambda (args)
			 (lambda ()
			   `(student ,args)))
		       '(ben-bitdiddle
                         alyssa-hacker
                         course-6-frosh
                         lambda-man))
                  '()
                  (list 'autonomous-agent)))


