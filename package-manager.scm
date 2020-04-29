;;; 6.905 Final Project
;;; Spring 2020
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Analysis

;(install-in-global!) ; to get the simple-analyzer

(define (extract-file-definitions filename environment)
  (let* ((file-analysis (analyze-file filename environment))
	 (definitions-analysis (car (analysis-children file-analysis))))
    (analysis-bound definitions-analysis)))

;;; Building default package

(define (create-package name things-to-build children)
  (make-package 'name name
                'things-to-build things-to-build
                'children children))

(define default-package
  (create-package 'default-package
                  '()
                  (list root)))

;;; generic install-package! and handlers 
(define install-package!
  (most-specific-generic-procedure 'install-package! 1 #f))

(define-generic-procedure-handler install-package!
  (match-args package?)
  (lambda (package)
    (install-package! (get-package-map package))
    (install-package! (get-package-objects package))
    (install-package! (get-package-rules package))))

(define-generic-procedure-handler install-package!
  (match-args package-objects?)
  (lambda (package-objects)
    (for-each (lambda (object)
                ;; check for name space problems
                (manage 'add (get-name object)))
              (get-objects package-objects))))

(define-generic-procedure-handler install-package!
  (match-args package-map?)
  (lambda (package-map)
    (for-each (lambda (place)
                ;; check for name space problems
                (manage 'add (get-name place)))
              (get-places package-map))))

(define-generic-procedure-handler install-package!
  (match-args package-rules?)
  (lambda (package-rules)
    (for-each (lambda (rule)
                ;; check for name space problems
                (manage 'add (get-name rule)))
              (get-rules package-rules))))



;;; Install default package at boot
(install-package! default-package)

#| ## TODO ## 
figure out how to see the definitions provided by manage with the simple analyzer
(define (conflicts-with-environment? package environment) ... )
|#

#| UI Stuff |#
(newline)
(display "Welcome to the adventure game package manager!\n")
(newline)
(display "Here's a few commands to get you started:\n")
(display "'list-packages' : returns the names of all currently installed packages\n")
(display "'install-package [package] [package] ...' : installs new packages onto default package\n")
(display "'start-adventure [your-name]' : begins an adventure in a world with all currently installed packages")

;;; Package Management

;;; Methods to examine current adventure
;; list packages

;; list places

;; list rules

;; list object-types


;;; Methods to add to world

#| ## TODO ##
Things we need to make this work
a) analyzer (above)
b) (use-package <name>) syntax in loadspec
|#


;;; Methods to remove from world

#| ## TODO ##
a) remove-handler message for generic
    (override the common/generics file?
b) update package listing and checking dependencies
|#

;; uninstall package

;; uninstall place

;; uninstall rule

;; uninstall object
