;; Copyright (c) 2006-2007 Carlos Ungil

(in-package :cl-user)

(defpackage "RCL"
  (:nicknames "R") 
  (:use "CL")
  (:export "R-INIT" "R-QUIT"
	   "R" "R%" 
	   "WITH-DEVICE" "ENABLE-RCL-SYNTAX"
	   "R-TO-LISP"
	   "NEW-STRING" "NEW-STRING-SINGLE"))
