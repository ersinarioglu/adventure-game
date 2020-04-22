;;; 6.905 Final Project                                                                                                                                                                                   
;;; Spring 2020                                                                                                                                                                                            
;;; Adventure World Package Manager                                                                                                                                                                       
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Package type definition
(define package:name
  (make-property 'name
		 'predicate symbol?))

(define package:map
  (make-property 'map
                 'predicate (lambda (x) (package-map? x))))
(define package:rules
  (make-property 'rules
                 'predicate (lambda (x) (package-rules? x))))
(define package:objects
  (make-property 'objects
                 'predicate (lambda (x) (package-objects? x))))
(define package?
  (make-type 'package (list package:map package:rules package:objects)))
(set-predicate<=! package? object?)

(define make-package
  (type-instantiator package?))

(define get-map
  (property-getter package:map package?))

(define set-map
  (property-setter package:map package? package-map?))

(define get-rules
  (property-getter package:rules package?))

(define set-rules
  (property-setter package:rules package? package-rules?))

(define get-objects
  (property-getter package:objects package?))

(define set-objects
  (property-setter package:objects package? package-objects?))

;;; generic procedure handlers?

(define-generic-procedure-handler install-package!
  (match-args package?)
  (lambda (package)
    (manage 'add (get-name package))))

(define-generic-procedure-handler uninstall-package! (match-args package?)
  <...>
  )

