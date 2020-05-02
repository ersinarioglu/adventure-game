
;;; Package type definition
(define package:things-to-build
  (make-property 'things-to-build
                 'predicate (is-list-of object?)
                 'default-value '()))

(define package:children
  (make-property 'children
                 'predicate (is-list-of object?)
                 'default-value '()))

(define package?
  (make-type 'package (list package:things-to-build package:children)))
(set-predicate<=! package? object?)

(define make-package
  (type-instantiator package?))

(define (create-package name things-to-build children)
  (make-package 'name name
		'things-to-build things-to-build
		'children children))

(define get-things-to-build
  (property-getter package:things-to-build package?))

(define add-thing-to-build!
  (property-adder package:things-to-build package? object?))

(define set-things-to-build!
  (property-setter package:things-to-build package? (is-list-of object?)))

(define get-children
  (property-getter package:children package?))

(define add-child!
  (property-adder package:children package? package?))

(define set-children!
  (property-setter package:children package? (is-list-of package?)))

(define build
  (simple-generic-procedure 'build 2
			    (lambda args (error "unknown object to build:" args))))

(define (add-build-handler tag handler)
  (define-generic-procedure-handler build
    (match-args (lambda (x) (eq? tag x))
		list?)
    (lambda (tag args)
      (handler args))))
