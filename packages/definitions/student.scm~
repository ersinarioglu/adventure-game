;;; 6.905 Final Project                                                                             
;;; Adventure World Package Manager                                                                 ;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

(define student
  (create-package 'student
                  (list 'ben-bitdiddle
                        'alyssa-hacker
                        'course-6-frosh
                        'lambda-man)
                  '()))
(define student?
  (make-type 'student '()))
(set-predicate<=! student? autonomous-agent?)

(define make-student
  (type-instantiator student?))
