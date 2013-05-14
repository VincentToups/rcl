;; Copyright (c) 2006-2012 Carlos Ungil

(in-package #:asdf)

(defsystem #:rcl-test
    :name "RCL test"
    :author "Carlos Ungil <ungil@mac.com>"
    :license "MIT"
    :description "http://common-lisp.net/project/rcl"
    :components ((:file "test"))
    :depends-on (:rcl :fiveam))

(defmethod asdf:perform ((op asdf:test-op) (c (eql (find-system ':rcl-test))))
  (funcall (intern "R-INIT" (find-package "RCL")))
  (funcall (intern "RUN" (find-package "FIVEAM"))
	   (intern "RCL-SUITE" (find-package "RCL-TEST"))))

