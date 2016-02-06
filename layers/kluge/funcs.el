(defun kluge-insert-date (arg)
  (interactive "P")
  (insert (cond
           ((not arg) (format-time-string "%Y-%m-%d"))
           ((equal arg '(4)) (format-time-string "%Y-%m-%dT%H:%M"))
           ((equal arg '(16)) (format-time-string "%Y-%m-%d %H:%M")))))

(defun kluge-write-whole-file ()
  (interactive)
  (evil-write nil nil))

;; Utility functions

(defun delete-from-list (list-var item)
  "Delete item from a list variable."
  (set list-var (delete item (symbol-value list-var))))
