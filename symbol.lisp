;; Copyright (c) 2006-2007 Carlos Ungil

(in-package :rcl)

(defclass r-symbol ()
  ((name :accessor name :initarg :name)
   (value :accessor value :initarg :value)
   (internal :accessor internal :initarg :internal)))

(defmethod print-object ((r-symbol r-symbol) stream) 
  (print-unreadable-object (r-symbol stream :type t :identity t)
     (format stream "~s" (name r-symbol))))
