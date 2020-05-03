;;; 6.905 Final Project
;;; Spring 2020
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; UI ANNOUNCEMENT

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

;;; ANALYSIS

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


;;; BUILD

(define build
  (simple-generic-procedure 'build 1
			    (lambda args (error "unknown object to build:" args))))

(define (tagged-list? tag)
  (lambda (x)
    (and (list? x)
	 (> (length x) 0)
	 (eq? tag (first x)))))

(define (add-build-handler tag handler)
  (define-generic-procedure-handler build
    (match-args (tagged-list? tag))
    (lambda (lst)
      (apply handler (cdr lst)))))

(define (build-package package)
  (let ((things-to-build (get-things-to-build package))
	(children (get-children package)))
    (append (map build things-to-build)
	    (reduce-left append '() (map build children)))))

(define-generic-procedure-handler build
  (match-args package?)
  build-package)

;;; PACKAGE TREE

(define (empty-tree)
  '())

(define package-tree (empty-tree))

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
  ())

(define (find-package-by-name package-name)
  (find (lambda (package)
	  (eq? (get-name package) package-name)) all-packages))

(define (install-package! point-of-install new-package)
  (let ((parent (find-package-by-name point-of-install))
        (child (find-package-by-name new-package)))
   (if parent (add-child! parent child))))

(define (uninstall-package! package-name) () ) 
;;; GAME STATE

#|
use environment-define to assign values built by 
build to symbols in the game environment
|#

(define build-game
  ())

(define build-people
  ())

(define clock)
(define all-places)
(define heaven)
(define all-people)
(define my-avatar)

(define (lowlevel-start-adventure name)
  (set! clock (make-clock))
  (set! all-places (build-game))
  (set! heaven (create-place 'heaven))
  (set! all-people (build-people all-places))
  (set! my-avatar
        (create-avatar name
                       (random-choice all-places)))
  (whats-here))
        
         
(define (start-adventure name)
  (let* ((files-to-install (list-packages))
         (game-env (make-environment
		     (map (lambda (filename) (load 'filename))
			  (files-to-install))
		     (lowlevel-start-adventure name))))
        (ge game-env)))

