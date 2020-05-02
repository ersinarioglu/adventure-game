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


(define package-tree (empty-tree))

(define (empty-tree)
  '())

(define (beginner-tree)
  (cons 'root '()))

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



(define my-tree (list 'world (list 'france
				   (list 'paris (list)))
		      (list 'spain
			    (list 'madrid (list)))
			    
		      (list 'turkey
			   (list 'ankara (list)))))

(tree:find-tree-with-root my-tree (lambda (x) (eq? x 'france)))

  




  
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
