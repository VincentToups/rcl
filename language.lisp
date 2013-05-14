;; Copyright (c) 2006-2007 Carlos Ungil

(in-package :rcl)

(defclass r-language ()
  ((value :accessor value :initarg :value)
   (expression :accessor expression :initarg :expression)
   (environment :accessor environment :initarg :environment)))

(defmethod print-object ((r-language r-language) stream) 
  (print-unreadable-object (r-language stream :type t :identity t)
     (format stream "~s" (expression r-language))))
