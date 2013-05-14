;; Copyright (c) 2006-2012 Carlos Ungil

;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:

;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
;; LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
;; OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
;; WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

(eval-when (:load-toplevel :compile-toplevel :execute)
  (pushnew :rcl *features*))

(in-package #:asdf)

(defsystem #:rcl
    :name "RCL"
    :author "Carlos Ungil <ungil@mac.com>"
    :license "MIT"
    :description "http://common-lisp.net/project/rcl"
    :components ((:file "defpackage")
                 (:file "config" :depends-on ("defpackage"))
                 (:file "init" :depends-on ("config"))
                 (:file "math" :depends-on ("init"))
                 (:file "alien-defs" :depends-on ("init"))	
                 (:file "types" :depends-on ("alien-defs"))	
                 (:file "alien-macros" :depends-on ("types"))	
                 (:file "vectors" :depends-on ("alien-macros"))
                 (:file "symbol" :depends-on ("alien-macros"))
                 (:file "promise" :depends-on ("alien-macros"))
                 (:file "language" :depends-on ("alien-macros"))
                 (:file "environment" :depends-on ("alien-macros"))
                 (:file "matrix" :depends-on ("defpackage"))
		 (:file "debug" :depends-on ("alien-macros"))
                 (:file "attributes" :depends-on ("symbol"))
		 (:file "r-pointer" :depends-on ("defpackage"))
                 (:file "decode" :depends-on ("vectors" "attributes" "types" "r-pointer"))
                 (:file "encode" :depends-on ("vectors" "r-pointer"))
		 (:file "funcall" :depends-on ("encode" "decode"))
                 (:file "streams" :depends-on ("funcall"))	
                 (:file "reader" :depends-on ("funcall"))		
                 (:file "high-level" :depends-on ("streams"))
                 (:file "devices" :depends-on ("high-level")))
    :depends-on (:cffi :trivial-garbage #+sbcl :sb-posix))

(defmethod asdf:perform ((op asdf:test-op) (c (eql (find-system ':rcl))))
  (asdf:operate 'asdf:load-op ':rcl-test)
  (asdf:operate 'asdf:test-op ':rcl-test))
