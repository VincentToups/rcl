(in-package :rcl)

(r-parse-eval "lm(Fertility ~ . , data = swiss)")

(r "lm" (r%-parse-eval "Fertility ~ .") :data (r-symbol "swiss"))

;; * FORMULA HANDLING *

(r-obj-decode (r%-parse-eval "Fertility ~ ."))
;; (LANGUAGE-CONSTRUCT #<R-SYMBOL "~" {100742ED03}>
;;  (#<R-SYMBOL "Fertility" {1007430463}> (#<R-SYMBOL "." {1007431B83}> :NIL :NIL)
;;   :NIL)
;;  :NIL)
;; ((:CLASS . "formula") (:.ENVIRONMENT . #<R-ENVIRONMENT :NIL {100742A813}>))

(r-obj-decode (r%-parse-eval "Fertility ~ ."))

;;;; (~ Fertility .)

(r-obj-decode (r%-parse-eval "response ~ this + that"))

;;;; (~ response (+ this that))



[_print [_lm (r%-parse-eval "Fertility ~ .") :data 'swiss]]
[_print [_lm [_as.formula "Fertility ~ ."] :data 'swiss]]
[_print [_lm [_~ 'Fertility '.] :data 'swiss]]
