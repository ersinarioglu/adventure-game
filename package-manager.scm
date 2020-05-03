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


(define (summary-file summary) (cadr (assq 'filename summary)))
(define (summary-free summary) (cadr (assq 'free summary)))
(define (summary-bound summary) (cadr (assq 'bound symmary)))

(define (make-by-name-index summaries)
  (let ((index (make-strong-eq-hash-table)))
    (for-each (lambda (summary)
		(let ((file (summary-file summary))
		      (bindings (summary-bound summary)))
		  (for-each (lambda (binding)
			      (hash-table-update!/default
			       index
			       binding
			       (lambda (definers)
				 (cons file definers))
			       (list file))
			      bindings))))
	      summaries)))

(define (conflicts by-name-index)
  (filter (lambda (name-definers-pair)
	    (> (length (cdr name-definers-pair)) 1))
	  (hash-table->alist by-name-index)))

(let ((here (directory-pathname (current-load-pathname))))
  (for-each (lambda (package-object-pathname)
	      (load (->namestring package-object-pathname)))
	    (filter (lambda (pn)
		      (not (string-prefix? "." (pathname-name pn))))
	     (directory-read (->namestring
			      (merge-pathnames
			       (->pathname "packages/objects/custom/")
			       here))))))


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

#|
Divide package objects into their own file - package definitions file and package object file are separate. Upon starting manager, the package object files are loaded. Upon starting an adventure, the package definitions files needed are loaded based on the package object files and their children 
Install-package command modifies tree that specifies the definitions files that will be loaded upon start-adventure
Start-adventure will create a new environment, load the definitions files into that environment, and switch the repl to that game environment |#

;;; THESE DEFINE A TREE DATA TYPE

(define package-tree (empty-tree))

(define (empty-tree)
  (list))

(define (new-tree-with-root name)
  (list name))

;; Gets the value of the root node in the tree.
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
  (define result #f)
  (define (find-tree-with-root-helper tree)
    ;(display (tree:get-sub-trees tree))
    (if (eq? tree (empty-tree))
	#f
	(if (predicate (tree:get-root tree))
	    (set! result tree)
	    (map find-tree-with-root-helper (tree:get-sub-trees tree)))))
  (find-tree-with-root-helper tree)
  result)


;; Adds given "new-tree" under node in "tree" that satisfies "predicate".
(define (tree:add-tree-to-place! tree predicate new-tree)
  (let ((sub-tree (tree:find-tree-with-root tree predicate)))
    (if subtree
	(append! sub-tree (list new-tree))
	#f)))

;; Adds given "object" as a node under a node that satisfies "predicate" in "tree"
(define (tree:add-object-to-place! tree predicate object)
  (tree:add-tree-to-place! tree predicate (list object)))


;;; NOW WE ADD UTILITIES FOR PACKAGES:

;; Finds package in list of "packages" that has "name"
(define (find-package-in-list packages name)
  (find (lambda (package)
	  (eq? name (get-name package))) packages))

(define (find-root-package packages)
  (find-package-in-list packages 'root))

;; Finds subtree in "tree" that has root package that has name "package-name"
(define (get-subtree-with-root-package tree package-name)
  (tree:find-tree-with-root tree (lambda (package)
				   (eq? (get-name package) package-name))))

(define (add-object-to-subtree-with-root-package! tree root-package-name
					   object)
  (tree:add-object-to-place! tree (lambda (package)
				    (eq? (get-name package) root-package-name))
			     object))

(define (add-list-of-packages-to-subtree! tree root-package-name objects)
  (define (helper object)
    (add-object-to-subtree-with-root-package! tree root-package-name object))
  (map helper objects))
	 
;; packages is a list of packages

(define (make-tree-from-packages packages)
  (define my-tree (list (get-root-package packages)))

  ;; Adds the children of a given "package" to "tree" if "package" is in "tree"
  (define (populate-children tree package)
    (add-list-of-packages-to-subtree! tree (get-name package)
				      (get-children package)))

  (define (populate-children-my-tree package)
    (populate-children my-tree package))
 
  (let loop ((leaves (list (get-root-package packages))))
    (map populate-children-my-tree leaves)
    (let ((new-leaves (map get-children leaves)))
      (if (> (length new-leaves 0))
	  (loop new-leaves)))))


  
    
    







(define my-tree (list 'world (list 'france
				   (list 'paris))
		      (list 'spain
			    (list 'madrid))
			    
		      (list 'turkey
			    (list 'ankara))))





(tree:find-tree-with-root my-tree (lambda (x)
				     (eq? 'spain x)))


  
;;; list packages must return packages in depth first order!
(define (list-packages)
  (

(define (find-package-by-name package-name)
  (find (lambda (package)
	  (eq? (get-name package) package-name)) (list-packages)))

(define (install-package! package-name)
  (let ((package (find-package-by-name package-name)))
    (

(define (load-


         
(define (start-adventure name)
  (let* ((files-to-install (list-packages))
         (game-env (make-environment
		     (map (lambda (filename) (load 'filename))
			  (files-to-install))
		     (lowlevel-start-adventure name))))
        (ge game-env)))


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
