;;; 6.905 Final Project                                                                                                                                                                                    
;;; Spring 2020                                                                                                                                                                                             
;;; Adventure World Package Manager                                                                                                                                                                         
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;; Rule type definition

(define package-rules:rules
  (make-property 'rules
                 'predicate (is-list-of object?) ;maybe make rule? type later
                 'default-value '()))

(define package-rules?
  (make-type 'package-rules (list package-rules:rules)))
(set-predicate<=! package-rules? package?)

(define make-package-rules
  (type-instantiator package-rules?))

(define get-rules
  (property-getter package-rules:rules package-rules?))

(define add-rule!
  (property-adder package-rules:rules package-rules? object?))

(define remove-rule!
  (property-remover package-rules:rules package-rules? object?))

(define-generic-procedure-handler install-package!
  (match-args package-rules?)
  (lambda (package-rules)
    (for-each (lambda (rule)
                (manage 'add (get-name rule)))
              (get-rules package-rules))))
              
