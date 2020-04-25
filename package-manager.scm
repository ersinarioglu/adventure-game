;;; 6.905 Final Project
;;; Spring 2020
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Analysis

(install-in-global!) ; to get the simple-analyzer

(define (extract-file-definitions filename environment)
  (let* ((file-analysis (analyze-file filename environment))
	 (definitions-analysis (car (analysis-children file-analysis))))
    (analysis-bound definitions-analysis)))

(define default-objects
  (create-package-objects 'default-objects
                          '()))

(define default-map
  (create-package-map 'default-map
                      '()))

(define default-rules
  (create-package-rules 'default-rules
                        '()))

(define default-package
  (create-package 'defualt-package
                  default-map
                  default-objects
                  default-rules)) 

;;; Install default package at boot
(install-package! default-package)

#| ## TODO ## 
figure out how to see the definitions provided by manage with the simple analyzer
(define (conflicts-with-environment? package environment) ... )
|#

#| UI Stuff |#

(display "Welcome to the adventure game package manager!\n")
(display "Here's a few commands to get you started:\n")
(display "'list-packages' : returns the names of all currently installed packages\n")
(display "'install-package [package] [package] ...' : installs new packages onto default package\n")
(display "'start-adventure [your-name]' : begins an adventure in a world with all currently
           installed packages")

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

(define (create-package-objects name objects)
  (make-package-objects 'name name
                        'objects objects))

(define (create-package-map name places)
  (make-package-map 'name name
                    'places places))

(define (create-package-rules name rules)
  (make-package-rules 'name name
                      'rules rules))

(define (create-package name map objects rules)
  (make-package 'name name
                'map map
                'objects objects
                'rules rules))

;; install package
(define install-package!
  (most-specific-generic-procedure 'install-package! 1 #f))

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
