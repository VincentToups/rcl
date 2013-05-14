;; Copyright (c) 2006-2012 Carlos Ungil

(declaim (optimize (debug 3)))

(in-package :rcl)

(defvar *r-funcall-debug* nil)

(defun r%-symbol (name)
  "Intern the symbol in the R image"
  (rf-install name))

(defun r%-variable (name)
  "Find the variable in the R image"
  (rf-findvar (rf-install name) *r-globalenv*))

(defun r-symbol (name)
  "Intern the symbol in the R image"
  (make-r-pointer (r%-symbol name)))

(defun r-variable (name)
  "Find the variable in the R image"
  (make-r-pointer (r%-variable name)))

(defun r-function (name)
  "Find the function in the R image"
  (when (member (r-type (rf-findvar (rf-install name) *r-globalenv*))
		'(:promise :closure :special-form 
		  :builtin-non-special-forms))
    (let ((result (rf-findfun (rf-install name) *r-globalenv*)))
      (when result (make-instance 'r-pointer :pointer result)))))
    
(defun r-funcall (function &rest args)
  "Call the function in the R image"
  (unless (eq *r-session* :running)
    (error "You have to execute (r-init) first"))
  (cffi:with-foreign-object (error-occurred :int)
    (let ((command (new-language-construct (1+ (count-if-not #'keywordp args))))
	  (r-function (r-function function)))
      (unless r-function (error "~A is not a valid function" function))
      (let ((list (sexp-union command)) 
	    cdr)
	(setf (listsxp-car list) (pointer r-function))
	(loop while args
	      do (let ((arg (pop args)))
		   (setf cdr (listsxp-cdr list))
		   (setf list (sexp-union cdr))
		   ;; named argument passed as two successive arguments :name value
		   (when (keywordp arg)
		     (setf (listsxp-tag list)
			   (rf-install (string-downcase
					(substitute #\_ #\- (symbol-name arg))))
			   arg (pop args)))
		   ;; named argument passed as cons (:name . value)
		   (when (and (consp arg) (keywordp (car arg)))
		     (setf (listsxp-tag list)
			   (rf-install (string-downcase
					(substitute #\_ #\- (symbol-name (car arg)))))
			   arg (cdr arg)))
		   (setf (listsxp-car list) (lisp-to-r arg)))))
      (when *r-funcall-debug* (print (r-to-lisp command)) (terpri))
      (let ((result 
	      #+sbcl
	      (sb-int:with-float-traps-masked 
		  (:underflow :overflow :inexact :divide-by-zero :invalid) 
		(r-tryeval command *r-globalenv* error-occurred))
	      #-sbcl
	      (r-tryeval command *r-globalenv* error-occurred)))
	(if (zerop (cffi:mem-aref error-occurred :int))
	    (make-r-pointer result)
	    (progn
;;	      (print (cffi:mem-aref error-occurred :int))
;;	      (print (type-of error-occurred))
;;	      (describe error-occurred)
	      (error "error calling ~A" function)))))))

