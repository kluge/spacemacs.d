(defun kluge-insert-date (arg)
  (interactive "P")
  (insert (cond
           ((not arg) (format-time-string "%Y-%m-%d"))
           ((equal arg '(4)) (format-time-string "%Y-%m-%dT%H:%M"))
           ((equal arg '(16)) (format-time-string "%Y-%m-%d %H:%M")))))

(defun kluge-write-whole-file ()
  (interactive)
  (evil-write nil nil))

(defun kluge-org-meta-return ()
  "org-meta-return and insert state"
  (interactive)
  (end-of-line)
  (org-meta-return)
  (evil-insert 1))

(defun kluge-org-insert-todo-heading (arg)
  "org-meta-return and insert state"
  (interactive "P")
  (end-of-line)
  (org-insert-todo-heading arg)
  (evil-insert 1))

(defun kluge-open-below-once ()
  "Emulate pressing o in normal state"
  (interactive)
  (evil-open-below 1))

;; Utility functions

(defun delete-from-list (list-var item)
  "Delete item from a list variable."
  (set list-var (delete item (symbol-value list-var))))
