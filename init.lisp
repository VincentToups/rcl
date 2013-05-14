;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((variable-name #+windows "PATH" #-windows "LD_LIBRARY_PATH")
        (separator #+windows ";" #-windows ":"))
    (let ((current #+sbcl (sb-posix:getenv variable-name)                    
		   #+abcl (ext:getenv variable-name)
		   #+ecl (ext:getenv variable-name)
		   #+openmcl (ccl::getenv variable-name)                   
                   #+allegro (sys:getenv variable-name)
		   #+clisp (ext:getenv variable-name)
                   #+lispworks (lispworks:environment-variable variable-name)
		   #+cmu (cffi:foreign-funcall "getenv" :string variable-name :string)))
      (unless (search *r-lib-path* current)
        (let ((new (concatenate 'string current
                                      (when current separator) *r-lib-path*)))
          #+sbcl (sb-posix:putenv (concatenate 'string variable-name "=" new))
	  #+abcl t ;; (setf (ext:getenv variable-name) new)
          #+ecl (ext:setenv variable-name new)
          #+openmcl (ccl:setenv variable-name new)
          #+allegro (setf (sys:getenv variable-name) new)
          #+clisp (setf (ext:getenv variable-name) new)
          #+lispworks (setf (lispworks:environment-variable variable-name) new)
	  #+cmu (cffi:foreign-funcall "setenv" :string variable-name :string new :boolean t :int))))))

(defun set-r-home (r-home)
  #+sbcl (sb-posix:putenv (concatenate 'string "R_HOME=" r-home))
  #+abcl t ;; (setf (ext:getenv "R_HOME") r-home)
  #+ecl (ext:setenv "R_HOME" r-home)
  #+openmcl (ccl::setenv "R_HOME" r-home)
  #+allegro (setf (sys:getenv "R_HOME") r-home)
  #+clisp (setf (ext:getenv "R_HOME") r-home)
  #+lispworks (setf (lispworks:environment-variable "R_HOME") r-home)
  #+cmu (cffi:foreign-funcall "setenv" :string "R_HOME" :string r-home :boolean t :int))

#+(and ecl (not dffi))
(defvar *r-lib-loaded* (ffi:load-foreign-library "/Library/Frameworks/R.framework/Resources/lib/libR.dylib"))

#-(and ecl (not dffi))
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *r-lib-loaded* nil)
  (unless *r-lib-loaded*
    (pushnew *r-lib-path* cffi:*foreign-library-directories*)
    (setf *r-lib-loaded* (cffi:load-foreign-library *r-lib*))))

(defvar *r-session* :inactive)

(cffi:defcvar "R_SignalHandlers" 
    #-cffi-features:x86-64 :unsigned-long 
    #+cffi-features:x86-64 :unsigned-long-long)
(cffi:defcvar "R_CStackLimit"
    #-cffi-features:x86-64 :unsigned-long 
    #+cffi-features:x86-64 :unsigned-long-long)
(cffi:defcvar "R_Interactive"
    #-cffi-features:x86-64 :unsigned-long 
    #+cffi-features:x86-64 :unsigned-long-long)

(defun disable-stack-checking ()
  (setf *r-cstacklimit* 
	#-cffi-features:x86-64 (1- (expt 2 32))
	#+cffi-features:x86-64 (1- (expt 2 64))))

(defun disable-signal-handling ()
  (setf *r-signalhandlers* 0))

(defun ensure-non-interactive ()
  ;; defaults to interactive depending on isatty()
  (setf *r-interactive* 0))

(defun r-init ()
  (ecase *r-session*
    (:running (warn "R already running"))
    (:stopped (error "R was already stopped, restarting is not supported"))
    (:inactive
     (set-r-home *r-home*)
     (disable-signal-handling)
     (cffi:with-foreign-object (argv :pointer 5)
       (setf (cffi:mem-aref argv :pointer 0)
	     (cffi:foreign-string-alloc "rcl")
	     (cffi:mem-aref argv :pointer 1)
	     (cffi:foreign-string-alloc "--silent")
	     (cffi:mem-aref argv :pointer 2) 
	     (cffi:foreign-string-alloc "--vanilla")
	     (cffi:mem-aref argv :pointer 3) 
	     (cffi:foreign-string-alloc "--no-save")
	     (cffi:mem-aref argv :pointer 4) 
	     (cffi:foreign-string-alloc "--max-ppsize=50000"))
       (rf-initialize-r 4 argv))
     ;; the first version called rf-initembeddedr, resulting in
     ;; "C stack usage too close to the limit" messages in
     ;; ClozureCL, CMUCL, SBCL, and Lispworks on Linux/MacOSX
     ;; and nothing worked afterwards (... not a valid function, 
     ;; and *globalenv* had named=0 and mark=0 instead of 2 and 1)
     ;; As it's done in RCLG we need to disable stack-checking
     ;; inside that function, which is defined in Rembedded.c as
     ;; Rf_initialize_R, R_Interactive=TRUE (Unix), setup_Rmainloop
     (disable-stack-checking)
     (ensure-non-interactive)
     #+cmu (ext:with-float-traps-masked
	       (:divide-by-zero :invalid) 
	     (setup-rmainloop))
     #+sbcl (sb-int:with-float-traps-masked 
		(:underflow :overflow :inexact :divide-by-zero :invalid) 
	      (setup-rmainloop))
     #-(or sbcl cmu) (setup-rmainloop)
     (setf *r-session* :running)))
  *r-session*)

;; stopping and restarting the embedded instance is not supported in R

(defun r-quit ()
  (if (eq *r-session* :running)
      (progn
	(rf-endembeddedr 1)
	(setf *r-session* :stopped))
      (warn "R was not running!"))
  *r-session*)

;;https://stat.ethz.ch/pipermail/r-help/2010-September/252039.html
;; void Rf_endEmbeddedR(int fatal)
;; {
;;     R_RunExitFinalizers();
;;     CleanEd();
;;     if(!fatal) KillAllDevices();
;;     R_CleanTempDir();
;;     if(!fatal && R_CollectWarnings)
;; 	PrintWarnings();	/* from device close and .Last */
;;     fpu_setup(FALSE);
;; }
