(defun kluge-insert-date (arg)
  (interactive "P")
  (insert (cond
           ((not arg) (format-time-string "%Y-%m-%d"))
           ((equal arg '(4)) (format-time-string "%Y-%m-%dT%H:%M"))
           ((equal arg '(16)) (format-time-string "%Y-%m-%d %H:%M")))))
