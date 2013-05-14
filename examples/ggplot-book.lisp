(in-package :rcl)

(enable-rcl-syntax)

[library 'ggplot2]

[print [_qplot 'carat 'price :data 'diamonds]]

;;[print [_qplot [_log 'carat] [_log 'price] :data 'diamonds]]
;; Doesn't work, carat and price are part of diamonds
[print (r%-parse-eval "qplot(log(carat),log(price),data=diamonds)")]

(progn 
  [attach 'diamonds]
  [print [_qplot [_log 'carat] [_log 'price]]]
  [detach 'diamonds])

;; this is not very nice, the name of the axes is not 
;; "log(carat)" and "log(price)"

(progn 
  [attach 'diamonds]
  [print [_qplot 'carat [_* [_* 'x 'y] 'z]]]
  [detach 'diamonds])

;; (let ((dsmall [_\[ 'diamonds [_sample [_nrow 'diamonds] 1000]]))
;;   [print [_qplot 'carat 'price :data dsmall :colour 'color]])

[print [_qplot 'carat 'price :geom '("smooth" "point") :data 'diamonds]]


[print [_qplot [_$ 'economics "date"] [_/ [_$ 'economics "unemploy"] [_$ 'economics "pop"]] :geom "line"]]





