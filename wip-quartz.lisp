(in-package :rcl)

(r-init)
(r "library" "CarbonEL")
(r "quartz")
(r "plot" (r-function "sin") -3.14 6.28)
(r "graphics.off")