(setq kluge-packages '(avy
                       cc-mode
                       cmake-mode
                       dired
                       evil
                       hippie-exp
                       ivy
                       ledger-mode
                       lsp-mode
                       magit
                       modern-cpp-font-lock
                       org
                       projectile
                       undo-tree
                       yasnippet))

(defun kluge/post-init-avy ()
  (define-key evil-motion-state-map (kbd "g SPC") 'avy-goto-char))

(defun kluge/post-init-cc-mode ()
   (c-add-style "kluge"
                '("stroustrup"
                  (c-offsets-alist
                   (innamespace . 0))))
   (setq c-default-style "kluge"))

(defun kluge/post-init-cmake-mode ()
  (setq cmake-tab-width 4))

(defun kluge/post-init-dired ()
    (setq-default dired-listing-switches "-alh")
    (setq dired-recursive-copies 'always) ; Don't prompt for copying directories
    (define-key dired-mode-map (kbd "-") 'dired-up-directory))

(defun kluge/post-init-evil ()
  (setq-default evil-shift-width 4)
  ;; Don't override M-., it is useful. Rotate the repeat ring with C-, instead.
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "C-,") 'evil-repeat-pop-next)

  (evil-define-key '(normal insert) c++-mode-map (kbd "M-RET") 'kluge-append-semicolon-at-eol)
  ;; Use other jump handlers instead of evil-goto-definition
  (setq spacemacs-default-jump-handlers (delete 'evil-goto-definition spacemacs-default-jump-handlers)))

(defun kluge/post-init-hippie-exp ()
  (define-key evil-insert-state-map (kbd "C-SPC") 'hippie-expand))

(defun kluge/post-init-ivy ()
  ;; Wrap aroud in beginning and end of candidate list
  (setq ivy-wrap t))

(defun kluge-ledger-insert-assets-tili ()
  (interactive)
  (ledger-navigate-end-of-xact)
  (evil-insert-newline-below)
  (indent-according-to-mode)
  (insert "a:tili"))

(defun kluge/post-init-ledger-mode ()
  (setq ledger-highlight-xact-under-point nil)
  (evil-define-key 'normal ledger-mode-map (kbd "ö t") 'kluge-ledger-insert-assets-tili))

(defun kluge/post-init-lsp-mode ()
  (let ((clangd-exe (or
                    (executable-find "clangd")
                    (executable-find "clangd-10")
                    (executable-find "clangd-9"))))
    (when clangd-exe
      (setq lsp-clients-clangd-executable clangd-exe))))

(defun kluge/post-init-magit ()
  (setq magit-revision-show-gravatars nil))

(defun kluge/init-modern-cpp-font-lock ()
  (use-package modern-cpp-font-lock
    :ensure t
    :config
    (modern-c++-font-lock-global-mode t)
    (spacemacs|diminish modern-c++-font-lock-mode)))

(defun kluge/pre-init-org ()
  (setq org-export-backends '(ascii html md latex odt)))

(defun kluge/post-init-org ()
  (setq org-adapt-indentation nil) ; Don't indent text body under headers

  (setq org-agenda-files '("~/org"))
  (setq org-default-notes-file "~/org/backlog.org")
  (setq org-refile-targets '((nil . (:maxlevel . 3))
                             (org-agenda-files . (:maxlevel . 1))))
  (setq org-journal-dir "~/journal/")
  (setq org-journal-file-format "%Y-%m-%d.org")
  (add-hook 'org-journal-after-entry-create-hook 'kluge-open-below-once)

  (setq org-todo-keywords
        '((sequence "BACKLOG(b!)" "TODO(t!)" "DOING(s!)" "WAITING(w!)" "|" "DONE(d!)")))
  ;; Log date when task state is changed
  (setq org-log-into-drawer t)
  (setq org-agenda-todo-ignore-scheduled 'future)

  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c b") 'org-switchb)
  (global-set-key (kbd "C-c l") 'org-store-link)
  (spacemacs/set-leader-keys "ot"
    '(lambda () (interactive) (find-file "~/org/todo.org")))

  (evil-define-key 'normal org-mode-map
    (kbd "M-<return>") 'kluge-org-meta-return
    (kbd "M-S-<return>") 'kluge-org-insert-todo-heading
    (kbd "ö t") 'org-todo
    )

  (setq org-capture-templates
        '(("b" "Backlog" entry (file "~/org/backlog.org")
           "* BACKLOG %?\n%U\n%i")
          ("B" "Backlog with link" entry (file "~/org/backlog.org")
           "* BACKLOG %?\n%U\n%i\n%a")
          ("t" "Todo" entry (file "~/org/todo.org")
           "* TODO %?\n%U\n%i")
          ("T" "Todo with link" entry (file "~/org/todo.org")
           "* TODO %?\n%U\n%i\n%a")
          ))

  ;; Start in insert state in capture mode
  (add-hook 'org-capture-mode-hook 'evil-insert-state)

  (add-hook 'org-mode-hook 'auto-fill-mode)
  )

(defun kluge/post-init-projectile ()
  ;; Use alien tools, but also follow .projectile ignores
  ;(setq projectile-indexing-method 'hybrid)
  )

(defun kluge/post-init-undo-tree ()
  ;; Don't pollute working tree with save files
  (setq undo-tree-auto-save-history nil))

(defun kluge/post-init-yasnippet ()
  (setq yas-snippet-dirs '("~/.spacemacs.d/snippets"))
  (add-hook 'yas-before-expand-snippet-hook
            'kluge--bind-tab-to-yas-next-field)
  (add-hook 'yas-after-exit-snippet-hook
            'kluge--restore-tab-binding-after-exit-snippet))
