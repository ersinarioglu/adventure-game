;;; 6.905 Final Project                                                                                                                                                                                    
;;; Spring 2020                                                                                                                                                                                           
;;; Adventure World Package Manager                                                                                                                                                                       
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;; Object type definition

(define package-objects:objects
  (make-property 'objects
                 'predicate (is-list-of object?)
                 'default-value '()))

(define package-objects?
  (make-type 'package-objects (list package-objects:objects)))
(set-predicate<=! package-objects? package?)

(define make-package-objects
  (type-instantiator package-objects?))

(define get-objects
  (property-getter package-objects:objects package-object?))

(define add-object!
  (property-adder package-objects:objects package-object? object?))

(define remove-object!
  (property-remover package:objects:objects package-object? object?))

(define-generic-procedure-handler install-package!
  (match-args package-objects?)
  (lambda (package-objects)
    (for-each (lambda (object)
                (manage 'add (get-name object)))
              (get-objects package-objects))))
      
