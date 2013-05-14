(defpackage :rcl-test
  (:use :cl :rcl)
  (:export "RUN"))

(in-package :rcl-test)

(defun run ()
  (5am:run 'rcl-test::rcl-suite))

(5am:def-suite rcl-suite)

(5am:in-suite rcl-suite)

(5am:test init
  (5am:is (eq :running (r-init))))

(5am:test sum
  (5am:is (equal '(4) (r "+" 2 2))))

(5am:test sum2
  (5am:is (equal '(22 23 24) (r "+" 20 '(2 3 4)))))

(5am:test new-string-single
  (5am:is (equal '("eo") (r-to-lisp (new-string-single "eo")))))

(5am:test new-string
      (5am:is (equal (loop repeat 10 collect "") (r-to-lisp (new-string 10)))))

(5am:test list 
  (5am:is (equal (r "list" '("A" "B") '("C" "D")) '(("A" "B") ("C" "D")))))

#-ALLEGRO
(5am:test matrix
  (5am:is (and (equal (rcl::names (r "matrix" '(1 2 3 4) :nrow 2 :dimnames '(("A" "B") ("C" "D"))))
		      '(("A" "B") ("C" "D")))
	       (equalp (rcl::matrix (r "matrix" '(1 2 3 4) :nrow 2 :dimnames '(("A" "B") ("C" "D"))))
		       #2A((1 3) (2 4))))))

;; (test quit
;;   (is (eq :stopped (r-quit))))

;; restarting is not supported by R
#+NIL
(5am:test init-and-quit-twice 
  (5am:is (r:r-init))
  (5am:is (null (r:r-quit)))
  (5am:is (r:r-init))
  (5am:is (null (r:r-quit))))
