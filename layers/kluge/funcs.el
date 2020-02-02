(defun kluge-append-semicolon-at-eol ()
  (interactive)
  (end-of-line)
  (insert ";"))

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

;; Don't use TAB in company-mode while expanding yasnippets. (Heavily based on
;; the the way Spacemacs disables smartparens temporarily during snippet
;; expansion.)
(defvar kluge--original-tab-binding-in-company-active-map nil)
(defvar kluge--yasnippet-expanding nil
  "Whether the snippet expansion is in progress.")

(defun kluge--bind-tab-to-yas-next-field ()
  "Handler for `yas-before-expand-snippet-hook'.
Bind TAB to yas-next-field for company-active-map and remember the initial binding."
  ;; Remember the initial smartparens state only once, when expanding a top-level snippet.
  (unless kluge--yasnippet-expanding
    (setq kluge--yasnippet-expanding t
          kluge--original-tab-binding-in-company-active-map (lookup-key company-active-map (kbd "TAB")))
    (define-key company-active-map (kbd "TAB") 'yas-next-field)
    (define-key company-active-map (kbd "<tab>") 'yas-next-field)))

(defun kluge--restore-tab-binding-after-exit-snippet ()
  "Handler for `yas-after-exit-snippet-hook'.
 Restore the original bindings of TAB in company-active-map."
  (setq kluge--yasnippet-expanding nil)
  (define-key company-active-map (kbd "TAB") kluge--original-tab-binding-in-company-active-map)
  (define-key company-active-map (kbd "<tab>") kluge--original-tab-binding-in-company-active-map))
