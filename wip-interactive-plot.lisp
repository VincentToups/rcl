(in-package :rcl)

;; works if XQuartz is already running
;; (but the graphic is never redraw)

(r "x11")
(r "plot" (r-function "sin") -3.14 6.28 :xlab "" :ylab "")
(r "graphics.off")
