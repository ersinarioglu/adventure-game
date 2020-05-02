;;; 6.905 Final Project
;;; Spring 2020
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; Analysis

;(define (extract-file-definitions filename environment)
;  (let* ((file-analysis (analyze-file filename environment))
;	 (definitions-analysis (car (analysis-children file-analysis))))
;    (analysis-bound definitions-analysis)))

(define summarize-file ; filename environment
  (lexical-reference (manage 'manager-environment) 'summarize-file))



;;; Building default package

(define (create-package name things-to-build children)
  (make-package 'name name
                'things-to-build things-to-build
                'children children))

(define default-package
  (create-package 'default-package
                  '()
                  (list root)))



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

#|
(define (start-adventure name root-file)
    (let game-env (make-environment (map (lambda (filename) (load “filename)) (file-to-install)) (lowlevel-start-adventure name))
        (ge game-env)))

Divide package objects into their own file - package definitions file and package object file are separate. Upon starting manager, the package object files are loaded. Upon starting an adventure, the package definitions files needed are loaded based on the package object files and their children 
Install-package command modifies tree that specifies the definitions files that will be loaded upon start-adventure
Start-adventure will create a new environment, load the definitions files into that environment, and switch the repl to that game environment
|#


(define package-tree (empty-tree))

(define (empty-tree)
  '())

;; Gets the root node of the tree
(define (tree:get-root tree)
  (car tree))

;; Gets the sub trees of the tree
(define (tree:get-sub-trees tree)
  (cdr tree))

;; Gets the child nodes of the root node of a tree
(define (tree:get-children tree)
  (map tree:get-root (tree:get-sub-trees tree)))

;; Finds a subtree within "tree" that has root that satisfies "predicate".
(define (tree:find-tree-with-root tree predicate)
  (if (eq? tree (empty-tree))
      #f
      (if (predicate (tree:get-root tree))
	  tree
	  (map tree:find-tree-with-root (get-sub-trees tree)))))
      

;; Can add a node to a certain location in a tree, where node satisfies "predicate".
(define (tree:add-child tree predicate)
  (let ((subtree (tree:find-tree-with-root tree predicate)))
    (append! (tree:get-children subtree) (list tree))))

(define my-tree (empty-tree))




  

(define (list-packages)
  "list packages")

(define (find-package-by-name package-name)
  (find (lambda (package)
	  (eq? (get-name package) package-name)) (list-packages)))

(define (install-package! package-name)
  (let ((package (find-package-by-name package-name)))
    (

(define (load-



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
