(in-package :rcl)

(r-init)

(enable-rcl-syntax)

[library 'Rmetrics]

(defvar *ftse.ret* 
  [_yahooSeries :symbols '("^FTSE") :quote '("Close") :from "1984-12-31"]); :getReturns t])

[_plot *ftse.ret*]

[_print [_summary *ftse.ret*]]
;R# Time Series:          
;R#  Name:               
;R! Error en cat(list(...), file, sep, fill, labels, append) : 
;R!   el argumento 2 (type 'S4') no es soportado por 'cat'

