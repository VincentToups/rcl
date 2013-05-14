;; Copyright (c) 2006-2007 Carlos Ungil

(in-package :rcl)

(defclass r-promise ()
  ((value :accessor value :initarg :value)
   (expression :accessor expression :initarg :expression)
   (environment :accessor environment :initarg :environment)))

(defmethod print-object ((r-promise r-promise) stream) 
  (print-unreadable-object (r-promise stream :type t :identity t)
     (format stream "~s" (expression r-promise))))
