
(define loaded-packages '())

;;; Package type definition
(define package:things-to-build
  (make-property 'things-to-build
                 'predicate (is-list-of object?)
                 'default-value '()))

(define package:children
  (make-property 'children
                 'predicate (is-list-of object?)
                 'default-value '()))

(define package:build-method
  (make-property 'build-method
		 'predicate procedure?
		 'default-value (lambda (things-to-build symbol-definer)
				  (map build things-to-build))))
(define package:parent
  (make-property 'parent
                 'predicate symbol?
                 'default-value '()))

(define package?
  (make-type 'package (list package:things-to-build
			    package:children
			    package:build-method
                            package:parent)))
(set-predicate<=! package? object?)

(define make-package
  (type-instantiator package?))

(define (create-package name things-to-build children parent #!optional build-method)
  (let ((created-package
	 (if (default-object? build-method)
	     (make-package 'name name
			   'things-to-build things-to-build
			   'children children
                           'parent parent)
	     (make-package 'name name
			   'things-to-build things-to-build
			   'children children
                           'parent parent
			   'build-method build-method))))
    (set! loaded-packages (cons created-package loaded-packages))
    created-package))

(define get-things-to-build
  (property-getter package:things-to-build package?))

(define add-thing-to-build!
  (property-adder package:things-to-build package? object?))

(define set-things-to-build!
  (property-setter package:things-to-build package? (is-list-of object?)))

(define get-children
  (property-getter package:children package?))

(define add-child!
  (property-adder package:children package? symbol?))

(define set-children!
  (property-setter package:children package? (is-list-of symbol?)))

(define remove-child
  (property-remover package:children package? symbol?))

(define get-build-method
  (property-getter package:build-method package?))

(define get-parent
  (property-getter package:parent package?))

(define set-parent!
  (property-setter package:parent package? symbol?))
