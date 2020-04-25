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

#| ## TODO ## 
figure out how to see the definitions provided by manage with the simple analyzer
(define (conflicts-with-environment? package environment) ... )
|#


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

;; install package
(

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
