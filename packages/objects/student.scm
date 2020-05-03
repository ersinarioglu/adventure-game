;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define student
  (create-package 'student
                  (map (lambda (args) `(student ,(args)))
		       '(ben-bitdiddle
                         alyssa-hacker
                         course-6-frosh
                         lambda-man))
                  '()))

(add-child! autonomous-agent student)
(append! all-packages (list student))
