;; Copyright (c) 2006-2012 Carlos Ungil

(in-package :rcl)

(defclass r-pointer ()
  ((pointer :initarg :pointer :accessor pointer)))

;;  clisp    ffi:foreign-address 
;;  cmu      sys:system-area-pointer
;;  openmcl  ccl:macptr
;;  sbcl     sb-sys:system-area-pointer
;;  allegro  integer
;;  ecl      foreign

(defun r-obj-p (thing)
  (typep thing 'r-pointer))

(defgeneric r-header (sexp))

(defgeneric r-type (sexp))

(defmethod r-header ((sexp r-pointer))
  (r-header (pointer sexp)))

(defmethod r-type ((sexp r-pointer))
  (r-type (pointer sexp)))

(defgeneric r-to-lisp (sexp))

(defgeneric r-obj-describe (sexp))

(defmethod r-to-lisp ((sexp r-pointer))
  (r-to-lisp (pointer sexp)))

(defmethod r-obj-describe ((sexp r-pointer))
  (r-obj-describe (pointer sexp)))

(defmethod print-object ((r-pointer r-pointer) stream)
  (print-unreadable-object (r-pointer stream :type t :identity t)
    (format stream "~s ~s" (r-obj-describe r-pointer) (pointer r-pointer))))

(defun make-r-pointer (ptr)
  (let ((r-pointer (make-instance 'r-pointer :pointer ptr)))
    (rf-protect ptr)
    (trivial-garbage:finalize r-pointer (lambda () (rf-unprotect-ptr ptr)))
    r-pointer))

;; (defmethod protect ((sexp r-pointer))
;;   (rf-protect (pointer sexp))
;;   sexp)

;; (defmethod unprotect ((sexp r-pointer))
;;   (rf-unprotect-ptr (pointer sexp)))
