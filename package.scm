
(define all-packages '())

;;; Package type definition

(define package:children
  (make-property 'children
                 'predicate (is-list-of symbol?)
                 'default-value '()))

(define package:parent
  (make-property 'parent
                 'predicate symbol?
                 'default-value '()))

(define package?
  (make-type 'package (list package:children
                            package:parent)))
(set-predicate<=! package? object?)

(define make-package
  (type-instantiator package?))

(define (create-package name children parent)
  (let ((created-package
	 (make-package 'name name
		       'children children
		       'parent parent)))
    (set! all-packages (cons created-package all-packages))
    created-package))

(define get-children
  (property-getter package:children package?))

(define add-child!
  (property-adder package:children package? symbol?))

(define set-children!
  (property-setter package:children package? (is-list-of symbol?)))

(define remove-child
  (property-remover package:children package? symbol?))

(define get-parent
  (property-getter package:parent package?))

(define set-parent!
  (property-setter package:parent package? symbol?))

(define remove-parent
  (property-setter package:parent package? null?))
