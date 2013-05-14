;; Copyright (c) 2006 Carlos Ungil

(in-package :rcl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *r-home* 
    #+darwin "/Library/Frameworks/R.framework/Resources/"
    #+windows "c:/Program Files/R/R-2.15.3/"
    #-(or darwin windows) "/usr/lib/R/")
  (defvar *r-lib-name*
    #+windows "R"
    #-windows "libR")
  (defvar *r-lib-extension*
    #+windows ".dll"
    #+darwin ".dylib"
    #-(or darwin windows) ".so")
  (defvar *r-lib* 
    (concatenate 'string *r-lib-name* *r-lib-extension*))
  (defvar *r-lib-path* 
    (concatenate 'string *r-home* 
		 #+(and windows cffi-features:x86) "bin/i386/"
                 #+(and windows cffi-features:x86-64) "bin/x64/"
		 #-windows "lib/"))
  (unless (probe-file (concatenate 'string *r-lib-path* *r-lib*))
    (error "Can't find library ~A in ~A, verify settings in config.lisp"
           *r-lib* *r-lib-path*)))





