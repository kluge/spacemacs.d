(setq kluge-packages '(avy
                       cc-mode
                       company-mode
                       evil
                       ivy
                       ledger-mode
                       org
                       magit
                       modern-cpp-font-lock
                       yasnippet))

(defun kluge/post-init-avy ()
  (define-key evil-motion-state-map (kbd "g SPC") 'avy-goto-char))

(defun kluge/post-init-cc-mode ()
   (c-add-style "kluge"
                '("stroustrup"
                  (c-offsets-alist
                   (innamespace . 0))))
   (setq c-default-style "kluge"))

(defun kluge/post-init-company-mode ()
  (bind-key "C-l" nil company-active-map)
  (bind-key "C-s" 'company-search-candidates company-active-map))

(defun kluge/init-dired+ ()
  (use-package dired+
    :init
    (setq-default dired-listing-switches "-alh")
    (setq dired-recursive-copies 'always) ; Don't prompt for copying directories
    :config
    (define-key dired-mode-map (kbd "-") 'dired-up-directory)))

(defun kluge/post-init-evil ()
  ;; Don't override M-., it is useful. Rotate the repeat ring with C-, instead.
  (define-key evil-normal-state-map (kbd "M-.") nil)
  (define-key evil-normal-state-map (kbd "C-,") 'evil-repeat-pop-next)
  ;; Use other jump handlers instead of evil-goto-definition
  (setq spacemacs-default-jump-handlers (delete 'evil-goto-definition spacemacs-default-jump-handlers)))

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

(defun kluge/post-init-org ()
  (setq org-adapt-indentation nil) ; Don't indent text body under headers

  (setq org-agenda-files '("~/org"))
  (setq org-default-notes-file "~/org/inbox.org")
  (setq org-refile-targets '((nil . (:maxlevel . 3))
                             (org-agenda-files . (:maxlevel . 1))))
  (setq org-journal-dir "~/journal/")
  (setq org-journal-file-format "%Y-%m-%d.org")
  (add-hook 'org-journal-after-entry-create-hook 'kluge-open-below-once)

  (setq org-todo-keywords
        '((sequence "TODO(t!)" "|" "DONE(d!)" "CANCELED(c@)")))
  ;; Log date when task state is changed
  (setq org-log-into-drawer t)

  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c b") 'org-iswitchb)
  (global-set-key (kbd "C-c l") 'org-store-link)

  (evil-define-key 'normal org-mode-map
    (kbd "M-<return>") 'kluge-org-meta-return
    (kbd "M-S-<return>") 'kluge-org-insert-todo-heading)

  (setq org-capture-templates
        '(("t" "Todo" entry (file "~/org/inbox.org")
           "* TODO %?\n%U\n%i")
          ("l" "Todo with link" entry (file "~/org/inbox.org")
           "* TODO %?\n%U\n%i\n%a")
          ("n" "Note" entry (file "~/org/inbox.org")
           "* %?\n%U\n%i\n")
          ("m" "Note with link" entry (file "~/org/inbox.org")
           "* %?\n%U\n%i\n%a")
          ("j" "Journal" entry (file+datetree "~/journal/2015.org")
           "* %U\n%?")))

  ;; Start in insert state in capture mode
  (add-hook 'org-capture-mode-hook 'evil-insert-state)

  (add-hook 'org-mode-hook 'auto-fill-mode)
  )

(defun kluge/post-init-magit ()
  (setq magit-revision-show-gravatars nil))

(defun kluge/init-modern-cpp-font-lock ()
  (use-package modern-cpp-font-lock
    :ensure t
    :config
    (modern-c++-font-lock-global-mode t)
    (spacemacs|diminish modern-c++-font-lock-mode)))

(defun kluge/post-init-yasnippet ()
  (bind-key "C-l" 'yas-expand yas-minor-mode-map))
