;;; 6.905 Final Project
;;; Spring 2020
;;; Adventure World Package Manager
;;; Gretchen Eggers, Ersin Arioglu, Nick Janovetz

;;; ANALYSIS

(define summarize-file ; filename environment
  (lexical-reference (manage 'manager-environment) 'summarize-file))


(define (summary-file summary) (cadr (assq 'filename summary)))
(define (summary-free summary) (cadr (assq 'free summary)))
(define (summary-bound summary) (cadr (assq 'defined summary)))

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
				 (if (any (lambda (item)
					    (equal? item file))
					  definers)
				     definers
				     (cons file definers)))
			       (list file)))
			    bindings)))
	      summaries)
    index))

(define (conflicts by-name-index)
  (filter (lambda (name-definers-pair)
	    (> (length (cdr name-definers-pair)) 1))
	  (hash-table->alist by-name-index)))

(define directory-path (directory-pathname (current-load-pathname)))

(define (sanitize-pathstring pathstring)
    (->namestring (merge-pathnames (->pathname pathstring) directory-path)))

(for-each (lambda (package-object-pathname)
	    (load (->namestring package-object-pathname)))
	  (filter (lambda (pn)
		    (not (string-prefix? "." (pathname-name pn))))
		  (directory-read (sanitize-pathstring "packages/objects/custom/"))))


;;; BUILD DEFAULT PACKAGE FROM ROOT

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

;;; TREE DATA TYPE

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
	
(define (tree:get-all-elements tree)
  (define result (list))
  (define (helper tree)
    (if (not (eq? tree (empty-tree)))
	(begin
	  (set! result (cons (tree:get-root tree) result))
	  (map helper (tree:get-sub-trees tree)))))
  (helper tree)
  result)

;; Adds given "new-tree" under node in "tree" that satisfies "predicate".
(define (tree:add-tree-to-place! tree predicate new-tree)
  (let ((sub-tree (tree:find-tree-with-root tree predicate)))
    (if sub-tree
	(append! sub-tree (list new-tree))
        #f)))

;; Adds given "object" as a node under a node that satisfies "predicate" in "tree"
(define (tree:add-object-to-place! tree predicate object)
  (tree:add-tree-to-place! tree predicate (list object)))


;;; TREE/PACKAGE UTILITIES:

;; Finds package in list of "packages" that has "name"
(define (find-package-in-list packages name)
  (find (lambda (package)
	  (eq? name (get-name package))) packages))

;; Fetch root package
(define (find-root-package packages)
  (find-package-in-list packages 'root))

;; Finds subtree in "tree" that has root package that has name "package-name"
(define (get-subtree-with-root-package tree package-name)
  (tree:find-tree-with-root tree (lambda (package)
				   (eq? (get-name package) package-name))))

;; Adds "object" in "tree", under node that has package name
;; "root-package-name"
(define (add-object-to-subtree-with-root-package! tree root-package-name
					   object)
  (tree:add-object-to-place! tree (lambda (package)
				    (eq? (get-name package) root-package-name))
			     object))

;; Adds "sub-tree" as a child to the node in "tree" with name "root-package-name"
(define (append-sub-tree! tree root-package-name sub-tree)
  (let ((append-node (get-subtree-with-root-package tree root-package-name)))
    (append! append-node (list sub-tree))))

;; Adds every object in "objects" in "tree" as children of node named "root-package-name"
(define (add-list-of-packages-to-subtree! tree root-package-name objects)
  (define (helper object)
    (add-object-to-subtree-with-root-package! tree root-package-name object))
  (map helper objects))

;; Returns a new tree made from packages not including the package with
;; "package-name".
(define (remove-package-from-tree tree package-name)
  (let ((excluded (filter (lambda (package)
			    (not (eq? (get-name package) package-name)))
			  (tree:get-all-elements tree))))
    (set! package-tree (make-tree-from-packages excluded))))
	 
;; Builds entire tree from root
(define (make-tree-from-packages packages)
  (define my-tree (list (find-root-package packages)))


  (define new-leaves (list))

  (define (get-child-packages package)
    (define (helper package-name)
      (find-package-in-list packages package-name))
    (map helper (get-children package)))


  ;; Adds the children of a given "package" to "tree" if "package" is in "tree"
  (define (populate-children tree package)
    (let ((child-packages (get-child-packages package)))
      (add-list-of-packages-to-subtree! tree (get-name package)
					child-packages)
      
      (set! new-leaves (append! new-leaves child-packages))))

  (define (populate-children-my-tree package)
    (populate-children my-tree package))
 
  (let loop ((leaves (list (find-root-package packages))))
    (set! new-leaves (list))
    (map populate-children-my-tree leaves)
    (if (> (length new-leaves) 0)
	(loop new-leaves)
	my-tree)))

;; Builds tree with root at package
(define (populate-subtree-from-package package)
  (define my-tree (list package))


  (define new-leaves (list))

  (define (get-child-packages package)
    (define (helper package-name)
      (find-package-in-list all-packages package-name))
    (map helper (get-children package)))


  ;; Adds the children of a given "package" to "tree" if "package" is in "tree"
  (define (populate-children tree package)
    (let ((child-packages (get-child-packages package)))
      (add-list-of-packages-to-subtree! tree (get-name package)
					child-packages)
      
      (set! new-leaves (append! new-leaves child-packages))))

  (define (populate-children-my-tree package)
    (populate-children my-tree package))
 
  (let loop ((leaves (list package)))
    (set! new-leaves (list))
    (map populate-children-my-tree leaves)
    (if (> (length new-leaves) 0)
	(loop new-leaves)
	my-tree)))

;; The default tree build
(define package-tree (make-tree-from-packages all-packages))

(define (find-package-by-name package-name)
  (find (lambda (package)
	  (eq? (get-name package) package-name)) all-packages))

;; Helper for list-packages
(define (longest-path-to-leaves-hash tree-in)
  (let ((hash (make-strong-eq-hash-table)))
    (let longest-depth ((tree tree-in))
      (let ((node (tree:get-root tree)))
	(hash-table/lookup
	 hash node
	 (lambda () hash-table-ref hash node)
	 (lambda ()
           (let ((children (tree:get-sub-trees tree)))
	     (if (null? children)
		 (begin
		   (hash-table-set! hash node 0)
		   0)
		 (let ((value (+ 1 (apply
				    max
				    (map longest-depth
					 children)))))
		   (hash-table-set! hash node value)
		   value)))))))
    hash))

;;; PACKAGE MANAGER UI
  
;;; list packages must return packages in ordering that doesn't violate dependency relationships!
(define (list-packages)
  (map car
       (sort (hash-table->alist
              (longest-path-to-leaves-hash package-tree))
            (lambda (p1 p2)
              (> (cdr p1) (cdr p2))))))


(define (list-installed-packages)
  (let ((installed-names (map get-name (list-packages))))
        (for-each (lambda (name)
                (let ((current-package (find-package-by-name name)))
                      (display "[")
                      (display name)
                      (display "]\n")
                                    )) installed-names)))
   
(define (list-all-packages)
  (let ((all-names (map get-name all-packages)))
        (for-each (lambda (name)
                (let ((current-package (find-package-by-name name)))
                      (display "[")
                      (display name)
                      (display "]")
                      (cond ((not (find-package-in-list (list-packages) name))
                             (display "*")))
                      (newline)
                                    )) all-names)))
  

(define (install-package! point-of-install new-package)
  (let ((parent (find-package-by-name point-of-install))
        (child (find-package-by-name new-package))
        (new-sub-tree '()))

    (cond ((and parent child)
           (add-child! parent new-package)
           (set-parent! child point-of-install)
           (cond ((not (null? (get-children child)))
                  (set! new-sub-tree (populate-subtree-from-package child))
                  (append-sub-tree! package-tree point-of-install new-sub-tree))
                 (else
                  (add-object-to-subtree-with-root-package! package-tree point-of-install child)))

            (display "\nInstallation successful."))
          
          ((and parent (not child))
           (display "\nOops, the package you're trying to install doesn't exist."))

          ((and (not parent) child)
           (display "\nOops, the point of installation doesn't exist- try listing the packages to see which packages are currently installed."))

          (else (display "\nNeither of those packages exist."))
          )))


(define (uninstall-package! package-name)
  (let ((the-package (find-package-by-name package-name)))
    
    (cond (the-package
           (let ((parent-name (get-parent the-package))
                 (children (get-subtree-with-root-package package-tree package-name)))
             (cond ((not (null? parent-name))
                    (remove-child (find-package-by-name parent-name) package-name)
                    (remove-parent the-package '())
                    (remove-package-from-tree package-tree package-name)
                    (cond (children
                           (display package-name)
                           (display " was uninstalled along with all of its children."))
                          (else
                           (display package-name)
                           (display " was uninstalled and had no children"))))
                   
                   (else (display "\nOops, this package can't be uninstalled! This is the root package.")))))
          (else (display "\nOops, this package can't uninstalled! It's not currently installed.")))))

;;; GAME STATE

(define (start-adventure name)
  (let* ((packages (list-packages))
	 (calling-env (nearest-repl/environment))
         (game-env (extend-top-level-environment calling-env))
	 (definitions-filenames
	   (map (lambda (package)
		  (sanitize-pathstring
		   (string-append "packages/definitions/"
				  (symbol->string (get-name package)))))
		packages))
	 (build-filenames
	  (map (lambda (package)
		 (sanitize-pathstring
		  (string-append "packages/build/"
				(symbol->string (get-name package)))))
	       packages)))

    (let ((conflicting-definers
	   (conflicts (make-by-name-index
		       (map (lambda (file)
			      (summarize-file file game-env))
			    (append definitions-filenames build-filenames))))))
      (if (null? conflicting-definers)
	  'ok
	  (error "conflicts:" conflicting-definers)))
								   
    
    (define (symbol-definer name value)
      (environment-define game-env name value))
    
    (symbol-definer 'retire-game (lambda ()
				   (write-line "farewell!")
				   (ge calling-env)))
    
    (for-each (lambda (definer) (load definer game-env)) definitions-filenames)

    (symbol-definer 'the-clock (make-clock))
    (symbol-definer 'heaven (build '(place heaven)))

    (load (sanitize-pathstring "adventure-game-ui") game-env)

    (let ((objects (apply append (map
		    (lambda (builder)
		      (let ((obj-lst (load builder game-env)))
			(if (list? obj-lst) obj-lst '())))
		    build-filenames))))
      (symbol-definer 'all-people (filter (environment-lookup game-env 'person?) objects))
      (symbol-definer 'my-avatar (build `(avatar ,name))))
    
    (eval '(whats-here) game-env)
    (ge game-env)))

;;; UI OPENING ANNOUNCEMENT

(newline)
(display "Welcome to the adventure game package manager!\n")
(display "Here's a few commands to get you started:\n\n")
(display  "---------------------------------------------------------------\n\n")
(display  "(list-installed-packages) : Returns the names of all currently installed packages.\n\n")
(display  "(list-all-packages) : Returns the names of all packages the manager can see.
Packages that are visible but not installed are marked with an asterisk. \n\n")
(display  "(install-package! [parent-package] [new-package]) : \nInstalls a new package as a child of parent package.\n\n")
(display "(uninstall-package! [package]) : \nUninstalls package and all of the package's children, if it exists and is currently installed.\n\n") 
(display "(start-adventure [your-name]) : \nBegins an adventure in a world with all currently installed packages.")
