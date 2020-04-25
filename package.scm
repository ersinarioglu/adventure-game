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

(define get-package-map
  (property-getter package:map package?))

(define set-package-map
  (property-setter package:map package? package-map?))

(define get-package-rules
  (property-getter package:rules package?))

(define set-package-rules
  (property-setter package:rules package? package-rules?))

(define get-package-objects
  (property-getter package:objects package?))

(define set-package-objects
  (property-setter package:objects package? package-objects?))

;;; generic procedure handlers

(define-generic-procedure-handler install-package!
  (match-args package?)
  (lambda (package)
    (manage 'add (get-name package))))

|# TODO: handle uninstall package
(define-generic-procedure-handler uninstall-package! (match-args package?)
  <...>
  )
#|
