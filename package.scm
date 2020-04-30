
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

